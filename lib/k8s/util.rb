# frozen_string_literal: true

module K8s
  # Miscellaneous helpers
  module Util
    module HashBackport
      refine Hash do
        def transform_keys
          each.with_object({}) do |(key, value), hash|
            hash[yield key] = value
          end
        end
      end
    end

    # Deep merge hashes
    #
    # @param input [Hash]
    # @param other [Hash]
    # @param overwrite_arrays [Boolean] when encountering an array, replace the array with the new array
    # @param union_arrays [Boolean] when encountering an array, use Array#union to combine with the existing array
    # @param keep_existing [Boolean] prefer old value over new value
    # @param merge_nil_values [Boolean] overwrite an existing value with a nil value
    # @param merge_non_hash [Boolean] calls .merge on objects that respond to .merge
    def self.deep_merge(input, other, overwrite_arrays: true, union_arrays: false, keep_existing: false, merge_nil_values: false, merge_non_hash: false)
      raise ArgumentError, "input expected to be Hash, was #{input.class.name}" unless input.is_a?(Hash)
      raise ArgumentError, "other expected to be Hash, was #{other.class.name}" unless other.is_a?(Hash)

      input.merge(other) do |key, old_value, new_value|
        case old_value
        when Hash
          raise "#{key} : #{new_value.class.name} can not be merged into a Hash" unless new_value.is_a?(Hash)

          deep_merge(
            old_value,
            new_value,
            overwrite_arrays: overwrite_arrays,
            union_arrays: union_arrays,
            keep_existing: keep_existing,
            merge_nil_values: merge_nil_values,
            merge_non_hash: merge_non_hash
          )
        when Array
          if overwrite_arrays
            new_value
          elsif union_arrays
            raise "#{key} : #{new_value.class.name} can not be merged into an Array" unless new_value.is_a?(Array)

            old_value | new_value
          else
            old_value + new_value
          end
        else
          if keep_existing
            old_value
          elsif new_value.nil? && merge_nil_values
            nil
          elsif merge_non_hash && old_value.respond_to?(:merge)
            old_value.merge(new_value)
          else
            new_value.nil? ? old_value : new_value
          end
        end
      end
    end

    PATH_TR_MAP = { '~' => '~0', '/' => '~1' }.freeze
    PATH_REGEX = %r{(/|~(?!1))}.freeze

    # Deep transform hash keys or hashes inside arrays
    #
    # @example Stringify hash keys using a symbol
    #   deep_transform_keys(hash, :to_s)
    #
    # @example Stringify hash keys using a block
    #   deep_transform_keys(hash) { |key| key.to_s.upcase }
    #
    # @param value [Hash,Array,Object]
    # @param transform_method [Symbol] for example :to_s
    def self.deep_transform_keys(value = nil, transform_method = nil, &block)
      case value
      when Array
        value.map { |v| deep_transform_keys(v, transform_method, &block) }
      when Hash
        {}.tap do |result|
          value.each do |key, value|
            new_key = if key.is_a?(String) || key.is_a?(Symbol)
                        transform_method ? key.send(transform_method) : block.call(key)
                      else
                        key
                      end
            result[new_key] = deep_transform_keys(value, transform_method, &block)
          end
        end
      else
        value
      end
    end

    # Yield with all non-nil args, returning matching array with corresponding return values or nils.
    #
    # Args must be usable as hash keys. Duplicate args will all map to the same return value.
    #
    # @param args [Array<nil, Object>]
    # @yield args
    # @yieldparam args [Array<Object>] omitting any nil values
    # @return [Array<nil, Object>] matching args array 1:1, containing yielded values for non-nil args
    def self.compact_map(args)
      func_args = args.compact

      values = yield func_args

      # Hash{arg => value}
      value_map = Hash[func_args.zip(values)]

      args.map{ |arg| value_map[arg] }
    end

    # Recursive compact for Hash/Array
    #
    # @param hash_or_array [Hash,Array]
    # @return [Hash,Array]
    def self.recursive_compact(hash_or_array)
      p = proc do |*args|
        v = args.last
        v.delete_if(&p) if v.respond_to?(:delete_if) && !v.is_a?(Array)
        v.nil? || v.respond_to?(:empty?) && (v.empty? && (v.is_a?(Hash) || v.is_a?(Array)))
      end

      hash_or_array.delete_if(&p)
    end

    # Produces a set of json-patch operations so that applying
    # the operations on a, gives you the results of b
    # Used in correctly patching the Kube resources on stack updates
    #
    # @param patch_to [Hash] Hash to compute patches against
    # @param patch_from [Hash] New Hash to compute patches "from"
    def self.json_patch(patch_to, patch_from)
      diffs = Hashdiff.diff(patch_to, patch_from, array_path: true)
      ops = []
      # Each diff is like:
      # ["+", ["spec", "selector", "food"], "kebab"]
      # ["-", ["spec", "selector", "drink"], "pepsi"]
      # or
      # ["~", ["spec", "selector", "drink"], "old value", "new value"]
      # the path elements can be symbols too, depending on the input hashes
      diffs.each do |diff|
        operator = diff[0]
        # substitute '/' with '~1' and '~' with '~0'
        # according to RFC 6901
        path = diff[1].map { |p| p.to_s.gsub(PATH_REGEX, PATH_TR_MAP) }
        if operator == '-'
          ops << {
            op: "remove",
            path: "/" + path.join('/')
          }
        elsif operator == '+'
          ops << {
            op: "add",
            path: "/" + path.join('/'),
            value: diff[2]
          }
        elsif operator == '~'
          ops << {
            op: "replace",
            path: "/" + path.join('/'),
            value: diff[3]
          }
        else
          raise "Unknown diff operator: #{operator}!"
        end
      end

      ops
    end
  end
end
