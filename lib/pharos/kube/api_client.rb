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

      # @param resource [Pharos::Kube::Resource]
      # @param namespace [String, nil] default if resource is missing namespace
      # @raise [Pharos::Kube::Error] unknown resource
      # @return [Pharos::Kube::ResourceClient]
      def client_for_resource(resource, namespace: nil)
        unless @api_version == resource.apiVersion
          raise Pharos::Kube::Error, "Invalid apiVersion=#{resource.apiVersion} for #{@api_version} client"
        end

        unless api_resource = api_resources.find{ |api_resource| api_resource.kind == resource.kind }
          raise Pharos::Kube::Error, "Unknown resource kind=#{api_resource.kind} for #{@api_version}"
        end

        ResourceClient.new(@transport, self, api_resource,
          namespace: resource.metadata.namespace || namespace,
        )
      end

      # TODO: skip non-namespaced resources if namespace is given, or ignore namespace?
      #
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
      # @param resources [Array<Pharos::Kube::ResourceClient>] default is all listable resources
      # @param namespace [String, nil]
      # @param labelSelector [nil, String, Hash{String => String}]
      # @param fieldSelector [nil, String, Hash{String => String}]
      # @return [Array<Pharos::Kube::Resource>]
      def list_resources(resources = nil, namespace: nil, labelSelector: nil, fieldSelector: nil)
        resources ||= self.resources.select{|resource| resource.list? }

        api_paths = resources.map{|resource| resource.path(namespace: namespace) }
        api_lists = @transport.gets(*api_paths,
           response_class: Pharos::Kube::API::MetaV1::List,
           query: ResourceClient.make_query(
             'labelSelector' => ResourceClient.selector_query(labelSelector),
             'fieldSelector' => ResourceClient.selector_query(fieldSelector),
           ),
         )

        resources.zip(api_lists).map {|resource, api_list| resource.process_list(api_list) }.flatten
      end
    end
  end
end
