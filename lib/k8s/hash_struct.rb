# frozen_string_literal: true

require 'k8s/util'

module K8s
  # Similar to RecursiveOpenStruct / Hashie, a Hash with dot notation accessors.
  #
  # All keys will be converted to strings.
  class HashStruct < Hash
    using K8s::Util::HashDeepMerge

    module ArrayHelper
      def <<(value)
        super(K8s::HashStruct.to_hash_struct(value))
      end
    end

    def self.to_hash_struct(obj)
      case obj
      when Array
        obj.map do |item|
          to_hash_struct(item)
        end.extend(ArrayHelper)
      when Hash
        HashStruct.new.tap do |new_hash|
          obj.each do |key, value|
            new_hash[key.to_s] = to_hash_struct(value)
          end
        end
      else
        obj
      end
    end

    # @param hash [Hash]
    def initialize(hash = {})
      super()
      hash.each do |key, value|
        send(:[]=, key.to_s, value)
      end
    end

    def []=(key, value)
      super(key.to_s, self.class.to_hash_struct(value))
    end

    def method_missing(meth, *args)
      if meth.to_s.end_with?('=')
        send(:[]=, meth.to_s[/(.*)=$/, 1], args.first)
      else
        fetch(meth.to_s) { fetch(meth.to_s.tr('_', '-'), nil) }
      end
    end

    def respond_to_missing?(meth, _include_private = false)
      meth.to_s.end_with?('=') || key?(meth.to_s) || key?(meth.to_s.tr('_', '-')) || super
    end

    # Removes empty and nil children
    def recursive_compact!
      K8s::Util.recursive_compact(self)
    end
  end
end
