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
      def initialize(transport, api_version)
        @transport = transport
        @api_version = api_version
      end

      # @return [String]
      def api_version
        @api_version
      end

      def path(*path)
        @transport.path(self.class.path(@api_version), *path)
      end

      # @return [Bool] loaded yet?
      def api_resources?
        !!@api_resources
      end

      # @param api_resources [Array<Pharos::Kube::API::MetaV1::APIResource>]
      def api_resources=(api_resources)
        @api_resources = api_resources
      end

      # @return [Array<Pharos::Kube::API::MetaV1::APIResource>]
      def api_resources
        @api_resources ||= @transport.get(self.path,
          response_class: Pharos::Kube::API::MetaV1::APIResourceList,
        ).resources
      end

      # @param resource_name [String]
      # @param namespace [String, nil]
      # @raise [Pharos::Kube::Error] unknown resource
      # @return [Pharos::Kube::ResourceClient]
      def resource(resource_name, namespace: nil)
        unless api_resource = api_resources.find{ |api_resource| api_resource.name == resource_name }
          raise Pharos::Kube::Error, "Unknown resource #{resource_name} for #{@api_version}"
        end

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

      # Pipline request list requests.
      # Returns flattened array with mixed resource kinds
      #
      # @param resources [Array<Pharos::Kube::ResourceClient>]
      # @param namespace [String, nil]
      # @return [Array<Pharos::Kube::Resource>]
      def list_resources(resources, namespace: nil, labelSelector: nil, fieldSelector: nil)
        # TODO: skip non-namespaced resources if namespace is set?
        api_paths = resources.map{|resource| resource.path(namespace: namespace) }
        api_lists = @transport.gets(*api_paths,
           response_class: Pharos::Kube::API::MetaV1::List,
           query: {
             'labelSelector' => labelSelector,
             'fieldSelector' => fieldSelector,
           },
         )
        api_lists_items = api_lists.map{|list| list.items.map {|item|
          # XXX: hack because list items do not include kind/apiVersion
          Pharos::Kube::Resource.new(apiVersion: list.apiVersion, kind: list.kind.sub(/List$/, ''), **item)
        } }

        api_lists_items.flatten
      end
    end
  end
end
