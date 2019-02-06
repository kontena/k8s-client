# frozen_string_literal: true

module K8s
  # generic typed resource
  class TypedResource < Dry::Struct
    using K8s::Util::HashDeepMerge

    transform_keys do |key|
      key = key.sub('$', '_') if key.is_a?(String)
      key.to_sym
    end
    input input.strict

    # @param api_path [String]
    # @return [K8s::TypedResource, Nil]
    def self.find_resource_class(api_path)
      path_registry[api_path]
    end

    # @param paths [Array<String>]
    def self.register_paths(paths)
      paths.each do |path|
        path_registry[path] = self
      end
    end

    # @return [Hash]
    def self.path_registry
      @@path_registry ||= {}
    end

    # merge in fields
    #
    # @param attrs [Hash, K8s::Resource]
    # @return [K8s::Resource]
    def merge(attrs)
      # deep clone of attrs
      h = to_hash

      # merge in-place
      h.deep_merge!(attrs.to_hash, overwrite_arrays: true, merge_nil_values: true)

      self.class.new(h)
    end

    # @example dig network provider
    #   config.dig("network", "provider")
    # @param keys [String,Symbol]
    # @return [Object,nil] returns nil when any part of the chain is unreachable
    def dig(*keys)
      keys.inject(self) do |memo, item|
        if memo.is_a?(Array) && item.is_a?(Integer)
          memo.send(:[], item)
        elsif memo.respond_to?(item.to_sym)
          memo.send(item.to_sym)
        end
      end
    end
  end
end
