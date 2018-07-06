module Pharos
  module Kube
    class APIClient
      # @param transport [Pharos::Kube::Transport]
      # @param api_version [String] "group/version" or "version" (core)
      def initialize(transport, api_version)
        @transport = transport
        @api_version = api_version
      end

      def path(*path)
        if @api_version.include? '/'
          @transport.path('/apis', @api_version, *path)
        else
          @transport.path('/api', @api_version, *path)
        end
      end

      # @return [Array<Pharos::Kube::API::MetaV1::APIResource>]
      def api_resources
        @api_resources ||= @transport.get(self.path,
          response_class: Pharos::Kube::API::MetaV1::APIResourceList,
        ).resources
      end

      # @return [Pharos::Kube::ResourceClient]
      def resource(resource_name, namespace: nil)
        api_resource = api_resources.find{|api_resource| api_resource[:name] == resource_name }

        fail "Unknown resource #{resource_name} for #{@api_version}" unless api_resource

        ResourceClient.new(@transport, self, api_resource,
          namespace: namespace,
        )
      end
    end
  end
end
