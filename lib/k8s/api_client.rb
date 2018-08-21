module K8s
  class APIClient
    def self.path(api_version)
      if api_version.include? '/'
        File.join('/apis', api_version)
      else
        File.join('/api', api_version)
      end

    end

    # @param transport [K8s::Transport]
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

    # @param api_resources [Array<K8s::API::MetaV1::APIResource>]
    def api_resources=(api_resources)
      @api_resources = api_resources
    end

    # Force-update APIResources
    #
    # @return [Array<K8s::API::MetaV1::APIResource>]
    def api_resources!
      @api_resources = @transport.get(self.path,
        response_class: K8s::API::MetaV1::APIResourceList,
      ).resources
    end

    # Cached APIResources
    #
    # @return [Array<K8s::API::MetaV1::APIResource>]
    def api_resources
      @api_resources || api_resources!
    end

    # @param resource_name [String]
    # @param namespace [String, nil]
    # @raise [K8s::Error] unknown resource
    # @return [K8s::ResourceClient]
    def resource(resource_name, namespace: nil)
      unless api_resource = api_resources.find{ |api_resource| api_resource.name == resource_name }
        raise K8s::Error::UndefinedResource, "Unknown resource #{resource_name} for #{@api_version}"
      end

      ResourceClient.new(@transport, self, api_resource,
        namespace: namespace,
      )
    end

    # @param resource [K8s::Resource]
    # @param namespace [String, nil] default if resource is missing namespace
    # @raise [K8s::Error::NotFound] API Group does not exist
    # @raise [K8s::Error::UndefinedResource]
    # @return [K8s::ResourceClient]
    def client_for_resource(resource, namespace: nil)
      unless @api_version == resource.apiVersion
        raise K8s::Error::UndefinedResource, "Invalid apiVersion=#{resource.apiVersion} for #{@api_version} client"
      end

      unless api_resource = api_resources.find{ |api_resource| api_resource.kind == resource.kind }
        raise K8s::Error::UndefinedResource, "Unknown resource kind=#{resource.kind} for #{@api_version}"
      end

      ResourceClient.new(@transport, self, api_resource,
        namespace: resource.metadata.namespace || namespace,
      )
    end

    # TODO: skip non-namespaced resources if namespace is given, or ignore namespace?
    #
    # @param namespace [String, nil]
    # @return [Array<K8s::ResourceClient>]
    def resources(namespace: nil)
      api_resources.map{ |api_resource| ResourceClient.new(@transport, self, api_resource,
        namespace: namespace,
      ) }
    end

    # Pipeline list requests for multiple resource types.
    #
    # Returns flattened array with mixed resource kinds.
    #
    # @param resources [Array<K8s::ResourceClient>] default is all listable resources for api
    # @param options @see [K8s::ResourceClient#list]
    # @return [Array<K8s::Resource>]
    def list_resources(resources = nil, **options)
      resources ||= self.resources.select{|resource| resource.list? }

      ResourceClient.list(resource, @transport, **options)
    end
  end
end
