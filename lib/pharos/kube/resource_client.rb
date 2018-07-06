module Pharos
  module Kube
    class ResourceClient
      # @param transport [Pharos::Kube::Transport]
      # @param api_client [Pharos::Kube::APIClient]
      # @param api_resource [Pharos::Kube::API::MetaV1::APIResource]
      # @param namespace [String]
      def initialize(transport, api_client, api_resource, namespace: nil)
        @transport = transport
        @api_client = api_client
        @api_resource = api_resource
        @namespace = namespace

        fail "Resource #{api_resource.name} is not namespaced" if namespace unless api_resource.namespaced
      end

      def path(*path)
        if @namespace
          @api_client.path('namespaces', @namespace, @api_resource.name, *path)
        else
          @api_client.path(@api_resource.name, *path)
        end
      end

      def get(name)
        @transport.request(
          method: 'GET',
          path: self.path(name),
        )
      end

      def list()
        @transport.request(
          method: 'GET',
          path: self.path(),
        )
      end
    end
  end
end
