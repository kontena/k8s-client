module Pharos
  module Kube
    class ResourceClient
      # @param transport [Pharos::Kube::Transport]
      # @param api_client [Pharos::Kube::APIClient]
      # @param api_resource [Pharos::Kube::API::MetaV1::APIResource]
      # @param namespace [String]
      def initialize(transport, api_client, api_resource, namespace: nil, resource_class: Pharos::Kube::Resource)
        @transport = transport
        @api_client = api_client
        @api_resource = api_resource
        @namespace = namespace
        @resource_class = resource_class

        fail "Resource #{api_resource.name} is not namespaced" if namespace unless api_resource.namespaced
      end

      # @return [String, nil]
      def namespace
        @namespace
      end

      # @return [String]
      def name
        @api_resource.name
      end

      # @return [String]
      def kind
        @api_resource.kind
      end

      # @return [Bool]
      def namespaced?
        !!@api_resource.namespaced
      end

      # @return [String]
      def path(*path, namespace: @namespace)
        if namespace
          @api_client.path('namespaces', namespace, @api_resource.name, *path)
        else
          @api_client.path(@api_resource.name, *path)
        end
      end

      # @return [Bool]
      def get?
        @api_resource.verbs.include? 'get'
      end

      # @return [resource_class]
      def get(name, namespace: @namespace)
        @transport.request(
          method: 'GET',
          path: self.path(name, namespace: namespace),
          response_class: @resource_class,
        )
      end

      # @return [Bool]
      def list?
        @api_resource.verbs.include? 'list'
      end

      # @return [Array<resource_class>]
      def list(labelSelector: nil, fieldSelector: nil, namespace: @namespace)
        list = @transport.request(
          method: 'GET',
          path: self.path(namespace: namespace),
          response_class: Pharos::Kube::API::MetaV1::List,
          query: {
            'labelSelector' => labelSelector,
            'fieldSelector' => fieldSelector,
          }.select{|k, v| !v.nil? },
        )
        list.items.map {|item|
          # list items omit kind/apiVersion
          @resource_class.new(apiVersion: list.apiVersion, kind: @api_resource.kind, **item)
        }
      end
    end
  end
end
