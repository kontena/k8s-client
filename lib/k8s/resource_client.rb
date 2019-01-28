# frozen_string_literal: true

module K8s
  # Per-APIResource type client.
  #
  # Used to get/list/update/patch/delete specific types of resources, optionally in some specific namespace.
  class ResourceClient
    # Common helpers used in both class/instance methods
    module Utils
      # @param selector [NilClass, String, Hash{String => String}]
      # @return [NilClass, String]
      def selector_query(selector)
        case selector
        when nil
          nil
        when String
          selector
        when Hash
          selector.map{ |k, v| "#{k}=#{v}" }.join ','
        else
          fail "Invalid selector type. #{selector.inspect}"
        end
      end

      # @param options [Hash]
      # @return [Hash, NilClass]
      def make_query(options)
        query = options.compact

        return nil if query.empty?

        query
      end
    end

    include Utils
    extend Utils

    # Pipeline list requests for multiple resource types.
    #
    # Returns flattened array with mixed resource kinds.
    #
    # @param resources [Array<K8s::ResourceClient>]
    # @param transport [K8s::Transport]
    # @param namespace [String, nil]
    # @param labelSelector [nil, String, Hash{String => String}]
    # @param fieldSelector [nil, String, Hash{String => String}]
    # @param skip_forbidden [Boolean] skip resources that return HTTP 403 errors
    # @return [Array<K8s::Resource>]
    def self.list(resources, transport, namespace: nil, labelSelector: nil, fieldSelector: nil, skip_forbidden: false)
      api_paths = resources.map{ |resource| resource.path(namespace: namespace) }
      api_lists = transport.gets(
        *api_paths,
        response_class: K8s::API::MetaV1::List,
        query: make_query(
          'labelSelector' => selector_query(labelSelector),
          'fieldSelector' => selector_query(fieldSelector)
        ),
        skip_forbidden: skip_forbidden
      )

      resources.zip(api_lists).map { |resource, api_list| api_list ? resource.process_list(api_list) : [] }.flatten
    end

    # @param transport [K8s::Transport]
    # @param api_client [K8s::APIClient]
    # @param api_resource [K8s::API::MetaV1::APIResource]
    # @param namespace [String]
    # @param resource_class [Class]
    def initialize(transport, api_client, api_resource, namespace: nil, resource_class: K8s::Resource)
      @transport = transport
      @api_client = api_client
      @api_resource = api_resource
      @namespace = namespace
      @resource_class = resource_class

      if @api_resource.name.include? '/'
        @resource, @subresource = @api_resource.name.split('/', 2)
      else
        @resource = @api_resource.name
        @subresource = nil
      end

      fail "Resource #{api_resource.name} is not namespaced" unless api_resource.namespaced || !namespace
    end

    # @return [String]
    def api_version
      @api_client.api_version
    end

    # @return [String] resource or resource/subresource
    def name
      @api_resource.name
    end

    # @return [String, nil]
    attr_reader :namespace

    # @return [String]
    attr_reader :resource

    # @return [Boolean]
    def subresource?
      !!@subresource
    end

    # @return [String, nil]
    attr_reader :subresource

    # @return [String]
    def kind
      @api_resource.kind
    end

    # @return [class] K8s::Resource
    attr_reader :resource_class

    # @return [Boolean]
    def namespaced?
      !!@api_resource.namespaced
    end

    # @param name [NilClass, String]
    # @param subresource [String, NilClass]
    # @param namespace [String, NilClass]
    # @return [String]
    def path(name = nil, subresource: @subresource, namespace: @namespace)
      namespace_part = namespace ? ['namespaces', namespace] : []

      if name && subresource
        @api_client.path(*namespace_part, @resource, name, subresource)
      elsif name
        @api_client.path(*namespace_part, @resource, name)
      else
        @api_client.path(*namespace_part, @resource)
      end
    end

    # @return [Bool]
    def create?
      @api_resource.verbs.include? 'create'
    end

    # @param resource [#metadata] with metadata.namespace and metadata.name set
    # @return [Object] instance of resource_class
    def create_resource(resource)
      @transport.request(
        method: 'POST',
        path: path(namespace: resource.metadata.namespace),
        request_object: resource,
        response_class: @resource_class
      )
    end

    # @return [Bool]
    def get?
      @api_resource.verbs.include? 'get'
    end

    # @param name [String]
    # @param namespace [String, NilClass]
    # @return [Object] instance of resource_class
    def get(name, namespace: @namespace)
      @transport.request(
        method: 'GET',
        path: path(name, namespace: namespace),
        response_class: @resource_class
      )
    end

    # @param resource [resource_class]
    # @return [Object] instance of resource_class
    def get_resource(resource)
      @transport.request(
        method: 'GET',
        path: path(resource.metadata.name, namespace: resource.metadata.namespace),
        response_class: @resource_class
      )
    end

    # @return [Bool]
    def list?
      @api_resource.verbs.include? 'list'
    end

    # @param list [K8s::API::MetaV1::List]
    # @return [Array<Object>] array of instances of resource_class
    def process_list(list)
      list.items.map { |item|
        # list items omit kind/apiVersion
        @resource_class.new(item.merge('apiVersion' => list.apiVersion, 'kind' => @api_resource.kind))
      }
    end

    # @param labelSelector [nil, String, Hash{String => String}]
    # @param fieldSelector [nil, String, Hash{String => String}]
    # @param namespace [nil, String]
    # @return [Array<Object>] array of instances of resource_class
    def list(labelSelector: nil, fieldSelector: nil, namespace: @namespace)
      list = meta_list(labelSelector: labelSelector, fieldSelector: fieldSelector, namespace: namespace)
      process_list(list)
    end

    # @param labelSelector [nil, String, Hash{String => String}]
    # @param fieldSelector [nil, String, Hash{String => String}]
    # @param namespace [nil, String]
    # @return [K8s::API::MetaV1::List]
    def meta_list(labelSelector: nil, fieldSelector: nil, namespace: @namespace)
      @transport.request(
        method: 'GET',
        path: path(namespace: namespace),
        response_class: K8s::API::MetaV1::List,
        query: make_query(
          'labelSelector' => selector_query(labelSelector),
          'fieldSelector' => selector_query(fieldSelector)
        )
      )
    end

    # @param labelSelector [nil, String, Hash{String => String}]
    # @param fieldSelector [nil, String, Hash{String => String}]
    # @param resourceVersion [nil, String]
    # @param timeout [nil, Integer]
    # @yield [K8S::API::MetaV1::WatchEvent]
    # @raise [Excon::Error]
    def watch(labelSelector: nil, fieldSelector: nil, resourceVersion: nil, timeout: nil, namespace: @namespace)
      method = 'GET'
      path = path(namespace: namespace)
      parser = Yajl::Parser.new
      parser.on_parse_complete = lambda do |data|
        event = K8s::API::MetaV1::WatchEvent.new(data)
        yield event
      end
      @transport.request(
        method: method,
        path: path,
        read_timeout: nil,
        query: make_query(
          'labelSelector' => selector_query(labelSelector),
          'fieldSelector' => selector_query(fieldSelector),
          'resourceVersion' => resourceVersion,
          'watch' => '1',
          'timeoutSeconds' => timeout
        ),
        response_block: lambda do |chunk, _, _|
          parser << chunk
        end
      )
    end

    # @return [Boolean]
    def update?
      @api_resource.verbs.include? 'update'
    end

    # @param resource [#metadata] with metadata.resourceVersion set
    # @return [Object] instance of resource_class
    def update_resource(resource)
      @transport.request(
        method: 'PUT',
        path: path(resource.metadata.name, namespace: resource.metadata.namespace),
        request_object: resource,
        response_class: @resource_class
      )
    end

    # @return [Boolean]
    def patch?
      @api_resource.verbs.include? 'patch'
    end

    # @param name [String]
    # @param obj [#to_json]
    # @param namespace [String, nil]
    # @param strategic_merge [Boolean] use kube Strategic Merge Patch instead of standard Merge Patch (arrays of objects are merged by name)
    # @return [Object] instance of resource_class
    def merge_patch(name, obj, namespace: @namespace, strategic_merge: true)
      @transport.request(
        method: 'PATCH',
        path: path(name, namespace: namespace),
        content_type: strategic_merge ? 'application/strategic-merge-patch+json' : 'application/merge-patch+json',
        request_object: obj,
        response_class: @resource_class
      )
    end

    # @param name [String]
    # @param ops [Hash] json-patch operations
    # @param namespace [String, nil]
    # @return [Object] instance of resource_class
    def json_patch(name, ops, namespace: @namespace)
      @transport.request(
        method: 'PATCH',
        path: path(name, namespace: namespace),
        content_type: 'application/json-patch+json',
        request_object: ops,
        response_class: @resource_class
      )
    end

    # @return [Boolean]
    def delete?
      @api_resource.verbs.include? 'delete'
    end

    # @param name [String]
    # @param namespace [String, nil]
    # @param propagationPolicy [String, nil] The propagationPolicy to use for the API call. Possible values include “Orphan”, “Foreground”, or “Background”
    # @return [K8s::API::MetaV1::Status]
    def delete(name, namespace: @namespace, propagationPolicy: nil)
      @transport.request(
        method: 'DELETE',
        path: path(name, namespace: namespace),
        query: make_query(
          'propagationPolicy' => propagationPolicy
        ),
        response_class: @resource_class # XXX: documented as returning Status
      )
    end

    # @param namespace [String, nil]
    # @param labelSelector [nil, String, Hash{String => String}]
    # @param fieldSelector [nil, String, Hash{String => String}]
    # @param propagationPolicy [String, nil]
    # @return [Array<Object>] array of instances of resource_class
    def delete_collection(namespace: @namespace, labelSelector: nil, fieldSelector: nil, propagationPolicy: nil)
      list = @transport.request(
        method: 'DELETE',
        path: path(namespace: namespace),
        query: make_query(
          'labelSelector' => selector_query(labelSelector),
          'fieldSelector' => selector_query(fieldSelector),
          'propagationPolicy' => propagationPolicy
        ),
        response_class: K8s::API::MetaV1::List # XXX: documented as returning Status
      )
      process_list(list)
    end

    # @param resource [resource_class] with metadata
    # @param options [Hash]
    # @see #delete for possible options
    # @return [K8s::API::MetaV1::Status]
    def delete_resource(resource, **options)
      delete(resource.metadata.name, namespace: resource.metadata.namespace, **options)
    end
  end
end
