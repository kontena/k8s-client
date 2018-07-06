module Pharos
  module Kube
    class APIClient
      def self.path(api_version)
        if api_version.include? '/'
          File.join('/apis', api_version)
        else
          File.join('/api', api_version)
        end

      end

      # @param transport [Pharos::Kube::Transport]
      # @param api_version [String] "group/version" or "version" (core)
      # @param api_resources [Array<Pharos::Kube::API::MetaV1::APIResource>]
      def initialize(transport, api_version, api_resources: nil)
        @transport = transport
        @api_version = api_version
        @api_resources = api_resources
      end

      # @return [String]
      def api_version
        @api_version
      end

      def path(*path)
        @transport.path(self.class.path(@api_version), *path)
      end

      # @return [Array<Pharos::Kube::API::MetaV1::APIResource>]
      def api_resources
        @api_resources ||= @transport.get(self.path,
          response_class: Pharos::Kube::API::MetaV1::APIResourceList,
        ).resources
      end

      # @param resource_name [String]
      # @param namespace [String, nil]
      # @return [Pharos::Kube::ResourceClient]
      def resource(resource_name, namespace: nil)
        api_resource = api_resources.find{ |api_resource| api_resource[:name] == resource_name }

        fail "Unknown resource #{resource_name} for #{@api_version}" unless api_resource

        ResourceClient.new(@transport, self, api_resource,
          namespace: namespace,
        )
      end

      # @param resource_name [String]
      # @param namespace [String, nil]
      # @return [Array<Pharos::Kube::ResourceClient>]
      def resources(namespace: nil)
        api_resources.map{ |api_resource| ResourceClient.new(@transport, self, api_resource,
          namespace: namespace,
        ) }
      end
    end
  end
end
