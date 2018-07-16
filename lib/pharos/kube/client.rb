require 'openssl'
require 'base64'

module Pharos
  module Kube
    def self.client(server, **options)
      Client.new(Transport.new(server, **options))
    end

    class Client
      # @param config [Phraos::Kube::Config]
      # @return [Pharos::Kube::Client]
      def self.config(config)
        new(Transport.config(config))
      end

      # @param server [String] URL with protocol://host:port - any /path is ignored
      def initialize(transport, namespace: nil)
        @transport = transport
        @namespace = namespace

        @api_clients = {}
      end

      # @raise [Pharos::Kube::Error]
      # @return [Pharos::Kube::API::Version]
      def version
        @transport.get('/version',
          response_class: Pharos::Kube::API::Version,
        )
      end

      # @param api_version [String] "group/version" or "version" (core)
      # @return [APIClient]
      def api(api_version = 'v1')
        @api_clients[api_version] ||= APIClient.new(@transport, api_version)
      end

      # @return [Array<String>]
      def api_versions
        @api_group_list ||= @transport.get('/apis',
          response_class: Pharos::Kube::API::MetaV1::APIGroupList,
        )

        @api_group_list.groups.map{|api_group| api_group.preferredVersion.groupVersion }
      end

      # @param api_versions [Array<String>] defaults to all APIs
      # @return [Array<APIClient>]
      def apis(api_versions = nil, prefetch_resources: false)
        api_versions ||= ['v1'] + self.api_versions

        if prefetch_resources
          # api groups that are missing their api_resources
          api_paths = api_versions
            .select{|api_version| !api(api_version).api_resources? }
            .map{|api_version| APIClient.path(api_version) }

          # load into APIClient.api_resources=
          @transport.gets(*api_paths, response_class: Pharos::Kube::API::MetaV1::APIResourceList).each do |api_resource_list|
            api(api_resource_list.groupVersion).api_resources = api_resource_list.resources
          end
        end

        api_versions.map{|api_version| api(api_version) }
      end

      # @param resource [Pharos::Kube::Resource]
      # @param namespace [String, nil] default if resource is missing namespace
      # @raise [Pharos::Kube::Error] unknown resource
      # @return [Pharos::Kube::ResourceClient]
      def client_for_resource(resource, namespace: nil)
        api(resource.apiVersion).client_for_resource(resource, namespace: namespace)
      end

      # @param resource [Pharos::Kube::Resource]
      # @return [Pharos::Kube::Resource]
      def create_resource(resource)
        client_for_resource(resource).create_resource(resource)
      end

      # @param resource [Pharos::Kube::Resource]
      # @return [Pharos::Kube::Resource]
      def get_resource(resource)
        client_for_resource(resource).get_resource(resource)
      end

      # @param resources [Array<Pharos::Kube::Resource>]
      # @return [Array<Pharos::Kube::Resource, nil>]
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

      # @param resource [Pharos::Kube::Resource]
      # @return [Pharos::Kube::Resource]
      def update_resource(resource)
        client_for_resource(resource).update_resource(resource)
      end

      # @param resource [Pharos::Kube::Resource]
      # @return [Pharos::Kube::Resource]
      def delete_resource(resource)
        client_for_resource(resource).delete_resource(resource)
      end
    end
  end
end
