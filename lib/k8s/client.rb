# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'yajl'
require 'monitor'
require 'uri'

require 'k8s/util'

require 'k8s/api/metav1'
require 'k8s/api/version'
require 'k8s/config'
require 'k8s/logging'
require 'k8s/api_client'
require "k8s/error"
require 'k8s/resource'
require 'k8s/resource_client'
require 'k8s/stack'
require 'k8s/transport'

module K8s
  # @param server [String] http/s URL
  # @param options [Hash]
  # @param (see Transport#initialize)
  # @return [K8s::Client]
  def self.client(server, **options)
    Client.new(Transport.new(server, **options))
  end

  # Top-level client wrapper.
  # Uses a {Transport} instance to talk to the kube API.
  # Offers access to {APIClient} and {ResourceClient} instances.
  class Client
    extend K8s::Util::ExceptionlessBangMethod

    # @param config [Phraos::Kube::Config]
    # @param namespace [String] default namespace for all operations
    # @param (see K8s::Transport.config)
    # @return [K8s::Client]
    def self.config(config, namespace: nil, **options)
      new(
        Transport.config(config, **options),
        namespace: namespace
      )
    end

    # An K8s::Client instance from in-cluster config within a kube pod, using the kubernetes service envs and serviceaccount secrets
    #
    # @param namespace [String] default namespace for all operations
    # @param (see K8s::Transport.in_cluster_config)
    # @return [K8s::Client]
    # @raise [K8s::Error::Config,Errno::ENOENT,Errno::EACCES]
    def self.in_cluster_config(namespace: nil, **options)
      new(Transport.in_cluster_config(**options), namespace: namespace)
    end

    # Attempts to create a K8s::Client instance automatically using environment variables, existing configuration
    # files or in cluster configuration.
    #
    # Look-up order:
    #   - KUBE_TOKEN, KUBE_CA, KUBE_SERVER environment variables
    #   - KUBECONFIG environment variable
    #   - $HOME/.kube/config file
    #   - In cluster configuration
    #
    # Will raise when no means of configuration is available
    #
    # @param namespace [String] default namespace for all operations
    # @param (see K8s::Transport.config)
    # @raise [K8s::Error::Config,Errno::ENOENT,Errno::EACCES]
    # @return [K8s::Client]
    def self.autoconfig(namespace: nil, **options)
      if ENV.values_at('KUBE_TOKEN', 'KUBE_CA', 'KUBE_SERVER').none? { |v| v.nil? || v.empty? }
        unless Base64.decode64(ENV['KUBE_CA']).match?(/CERTIFICATE/)
          raise ArgumentError, 'KUBE_CA does not seem to be base64 encoded'
        end

        begin
          token = options[:auth_token] || Base64.strict_decode64(ENV['KUBE_TOKEN'])
        rescue ArgumentError
          raise ArgumentError, 'KUBE_TOKEN does not seem to be base64 encoded'
        end

        configuration = K8s::Config.build(server: ENV['KUBE_SERVER'], ca: ENV['KUBE_CA'], auth_token: token)
      elsif !ENV['KUBECONFIG'].to_s.empty?
        configuration = K8s::Config.from_kubeconfig_env(ENV['KUBECONFIG'])
      elsif File.exist?(File.join(Dir.home, '.kube', 'config'))
        configuration = K8s::Config.load_file(File.join(Dir.home, '.kube', 'config'))
      end

      if configuration
        config(configuration, namespace: namespace, **options)
      else
        in_cluster_config(namespace: namespace, **options)
      end
    end

    include MonitorMixin

    # @return [K8s::Transport]
    attr_reader :transport

    # @param transport [K8s::Transport]
    # @param namespace [String, nil] default namespace for all operations
    def initialize(transport, namespace: nil)
      @transport = transport
      @namespace = namespace

      @api_clients = {}
      super()
    end

    # @raise [K8s::Error]
    # @return [K8s::API::Version]
    def version
      @version ||= @transport.version
    end

    # @param api_version [String] "group/version" or "version" (core)
    # @return [APIClient]
    def api(api_version = 'v1')
      @api_clients[api_version] ||= APIClient.new(@transport, api_version)
    end

    # Force-update /apis cache.
    # Required if creating new CRDs/apiservices.
    #
    # @return [Array<String>]
    def api_groups!
      synchronize do
        @api_groups = @transport.get(
          '/apis',
          response_class: K8s::API::MetaV1::APIGroupList
        ).groups.flat_map{ |api_group| api_group.versions.map(&:groupVersion) }

        @api_clients.clear
      end

      @api_groups
    end

    # Cached /apis preferred group apiVersions
    # @return [Array<String>]
    def api_groups
      @api_groups || api_groups!
    end

    # @param api_versions [Array<String>] defaults to all APIs
    # @param prefetch_resources [Boolean] prefetch any missing api_resources for each api_version
    # @param skip_missing [Boolean] return APIClient without api_resources? if 404
    # @return [Array<APIClient>]
    def apis(api_versions = nil, prefetch_resources: false, skip_missing: false)
      api_versions ||= ['v1'] + api_groups

      if prefetch_resources
        # api groups that are missing their api_resources
        api_paths = api_versions
                    .uniq
                    .reject{ |api_version| api(api_version).api_resources? }
                    .map{ |api_version| APIClient.path(api_version) }

        # load into APIClient.api_resources=
        begin
          @transport.gets(*api_paths, response_class: K8s::API::MetaV1::APIResourceList, skip_missing: skip_missing).each do |api_resource_list|
            api(api_resource_list.groupVersion).api_resources = api_resource_list.resources if api_resource_list
          end
        rescue K8s::Error::NotFound, K8s::Error::ServiceUnavailable # rubocop:disable Lint/HandleExceptions
          # kubernetes api is in unstable state
          # because this is only performance optimization, better to skip prefetch and move on
        end
      end

      api_versions.map{ |api_version| api(api_version) }
    end

    # @param namespace [String, nil]
    # @return [Array<K8s::ResourceClient>]
    def resources(namespace: nil)
      apis(prefetch_resources: true).map { |api|
        begin
          api.resources(namespace: namespace)
        rescue K8s::Error::ServiceUnavailable, K8s::Error::NotFound
          []
        end
      }.flatten
    end

    # Pipeline list requests for multiple resource types.
    #
    # Returns flattened array with mixed resource kinds.
    #
    # @param resources [Array<K8s::ResourceClient>] default is all listable resources for api
    # @param (see K8s::ResourceClient.list)
    # @return [Array<K8s::Resource>]
    def list_resources(resources = nil, **options)
      cached_clients = @api_clients.size.positive?
      resources ||= self.resources.select(&:list?)

      begin
        ResourceClient.list(resources, @transport, **options)
      rescue K8s::Error::NotFound
        raise unless cached_clients

        cached_clients = false
        api_groups!
        retry
      end
    end

    # @param resource [K8s::Resource]
    # @param namespace [String, nil] default if resource is missing namespace
    # @raise [K8s::Error::NotFound] API Group does not exist
    # @raise [K8s::Error::UndefinedResource]
    # @return [K8s::ResourceClient]
    def client_for_resource(resource, namespace: nil)
      api(resource.apiVersion).client_for_resource(resource, namespace: namespace)
    end

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def create_resource(resource)
      client_for_resource(resource).create_resource(resource)
    end
    exceptionless_bang_method :create_resource

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def get_resource(resource)
      client_for_resource(resource).get_resource(resource)
    end
    exceptionless_bang_method :get_resource

    # Returns nils for any resources that do not exist.
    # This includes custom resources that were not yet defined.
    #
    # @param resources [Array<K8s::Resource>]
    # @return [Array<K8s::Resource, nil>] matching resources array 1:1
    def get_resources(resources)
      # prefetch api resources, skip missing APIs
      resource_apis = apis(resources.map(&:apiVersion), prefetch_resources: true, skip_missing: true)

      # map each resource to excon request options, or nil if resource is not (yet) defined
      requests = resources.zip(resource_apis).map{ |resource, api_client|
        next nil unless api_client.api_resources?

        resource_client = api_client.client_for_resource(resource)

        {
          method: 'GET',
          path: resource_client.path(resource.metadata.name, namespace: resource.metadata.namespace),
          response_class: resource_client.resource_class
        }
      }

      # map non-nil requests to response objects, or nil for nil request options
      Util.compact_map(requests) { |reqs|
        @transport.requests(*reqs, skip_missing: true)
      }
    end

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def update_resource(resource)
      client_for_resource(resource).update_resource(resource)
    end
    exceptionless_bang_method :update_resource

    # @param resource [K8s::Resource]
    # @param (see ResourceClient.delete)
    # @return [K8s::Resource]
    def delete_resource(resource, **options)
      client_for_resource(resource).delete_resource(resource, **options)
    end
    exceptionless_bang_method :delete_resource

    # @param resource [K8s::Resource]
    # @param attrs [Hash]
    # @return [K8s::Client]
    def patch_resource(resource, attrs)
      client_for_resource(resource).json_patch(resource.metadata.name, attrs)
    end
    exceptionless_bang_method :patch_resource
  end
end
