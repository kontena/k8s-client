# frozen_string_literal: true

module K8s
  # Miscellaneous helpers
  module Util
    module HashDeepMerge
      refine Hash do
        def deep_merge(other, overwrite_arrays: true, union_arrays: true, keep_existing: false, merge_nil_values: true)
          merge(other) do |_, old_value, new_value|
            case old_value
            when Hash
              raise "#{new_value.class.name} can not be merged into a Hash" unless new_value.kind_of?(Hash)
              old_value.deep_merge(new_value)
            when Array
              if overwrite_arrays
                new_value
              else
                raise "#{new_value.class.name} can not be merged into an Array" unless new_value.kind_of?(Array)
                if union_arrays
                  old_value | new_value
                else
                  old_value + new_value
                end
              end
            else
              if keep_existing
                old_value
              else
                if new_value.nil? && merge_nil_values
                  nil
                else
                  new_value
                end
              end
            end
          end
        end

        def deep_merge!(other, **options)
          replace(deep_merge(other, **options))
        end
      end
    end

    PATH_TR_MAP = { '~' => '~0', '/' => '~1' }.freeze
    PATH_REGEX = %r{(/|~(?!1))}.freeze

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
      diffs = HashDiff.diff(patch_to, patch_from, array_path: true)
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
