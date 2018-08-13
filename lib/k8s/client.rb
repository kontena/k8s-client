require 'openssl'
require 'base64'

module K8s
  # @return [K8s::Client]
  def self.client(server, **options)
    Client.new(Transport.new(server, **options))
  end

  class Client
    # @param config [Phraos::Kube::Config]
    # @return [K8s::Client]
    def self.config(config)
      new(Transport.config(config))
    end

    # @return [K8s::Client]
    def self.in_cluster_config
      new(Transport.in_cluster_config)
    end

    # @param transport [K8s::Transport]
    def initialize(transport, namespace: nil)
      @transport = transport
      @namespace = namespace

      @api_clients = {}
    end

    # @raise [K8s::Error]
    # @return [K8s::API::Version]
    def version
      @transport.get('/version',
        response_class: K8s::API::Version,
      )
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
      @api_groups = @transport.get('/apis',
        response_class: K8s::API::MetaV1::APIGroupList,
      ).groups.map{|api_group| api_group.preferredVersion.groupVersion }
    end

    # Cached /apis preferred group apiVersions
    # @return [Array<String>]
    def api_groups
      @api_groups || api_groups!
    end

    # @param api_versions [Array<String>] defaults to all APIs
    # @return [Array<APIClient>]
    def apis(api_versions = nil, prefetch_resources: false)
      api_versions ||= ['v1'] + self.api_groups

      if prefetch_resources
        # api groups that are missing their api_resources
        api_paths = api_versions
          .select{|api_version| !api(api_version).api_resources? }
          .map{|api_version| APIClient.path(api_version) }

        # load into APIClient.api_resources=
        @transport.gets(*api_paths, response_class: K8s::API::MetaV1::APIResourceList).each do |api_resource_list|
          api(api_resource_list.groupVersion).api_resources = api_resource_list.resources
        end
      end

      api_versions.map{|api_version| api(api_version) }
    end

    # @param namespace [String, nil]
    # @return [Array<K8s::ResourceClient>]
    def resources(namespace: nil)
      apis(prefetch_resources: true).map { |api| api.resources(namespace: namespace) }.flatten
    end

    # Pipeline list requests for multiple resource types.
    #
    # Returns flattened array with mixed resource kinds.
    #
    # @param resources [Array<K8s::ResourceClient>] default is all listable resources for api
    # @param **options @see [K8s::ResourceClient#list]
    # @return [Array<K8s::Resource>]
    def list_resources(resources = nil, **options)
      resources ||= self.resources.select{|resource| resource.list? }

      ResourceClient.list(resources, @transport, **options)
    end

    # @param resource [K8s::Resource]
    # @param namespace [String, nil] default if resource is missing namespace
    # @raise [K8s::Error] unknown resource
    # @return [K8s::ResourceClient]
    def client_for_resource(resource, namespace: nil)
      api(resource.apiVersion).client_for_resource(resource, namespace: namespace)
    end

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def create_resource(resource)
      client_for_resource(resource).create_resource(resource)
    end

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def get_resource(resource)
      client_for_resource(resource).get_resource(resource)
    end

    # @param resources [Array<K8s::Resource>]
    # @return [Array<K8s::Resource, nil>]
    # @raise [K8s::Error::NotFound] if resource definition is missing
    def get_resources(resources)
      # prefetch api resources
      apis(resources.map{|resource| resource.apiVersion }.uniq, prefetch_resources: true)

      resource_clients = resources.map{|resource| client_for_resource(resource) }
      requests = resources.zip(resource_clients).map{|resource, resource_client|
        {
          method: 'GET',
          path: resource_client.path(resource.metadata.name, namespace: resource.metadata.namespace),
          response_class: resource_client.resource_class,
        }
      }
      responses = @transport.requests(*requests, skip_missing: true)
    end

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def update_resource(resource)
      client_for_resource(resource).update_resource(resource)
    end

    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def delete_resource(resource)
      client_for_resource(resource).delete_resource(resource)
    end
  end
end
