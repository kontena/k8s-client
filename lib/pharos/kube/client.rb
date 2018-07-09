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

      # @return [Hash{major, minor, ...}]
      def version
        @transport.get('/version')
      end

      # @param api_version [String] "group/version" or "version" (core)
      # @return [APIClient]
      def api(api_version = 'v1', **options)
        @api_clients[api_version] ||= APIClient.new(@transport, api_version, **options)
      end

      # @return [Array<APIClient>]
      def apis(prefetch_resources: false)
        api_group_list = @transport.get('/apis',
          response_class: Pharos::Kube::API::MetaV1::APIGroupList,
        )

        if prefetch_resources
          api_paths = api_group_list.groups.map{|api_group| APIClient.path(api_group.preferredVersion.groupVersion) }
          api_resources_list = @transport.gets(*api_paths, response_class: Pharos::Kube::API::MetaV1::APIResourceList)
          api_resources_hash = Hash[api_resources_list.map{|api_resource_list|
            [api_resource_list.groupVersion, api_resource_list.resources]
          }]
        else
          api_resources_hash = {}
        end

        api_group_list.groups.map{|api_group| api(api_group.preferredVersion.groupVersion,
            api_resources: api_resources_hash[api_group.preferredVersion.groupVersion],
        ) }
      end
    end
  end
end
