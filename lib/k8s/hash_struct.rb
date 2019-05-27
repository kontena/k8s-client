# frozen_string_literal: true

require 'k8s/util'
require 'k8s/type'

module K8s
  # Similar to RecursiveOpenStruct / Hashie, a Hash with dot notation accessors.
  #
  # All keys will be converted to strings.
  class HashStruct < Hash
    module ArrayHelper
      def <<(value)
        super(K8s::HashStruct.to_hash_struct(value))
      end
    end

    def self.to_hash_struct(obj, klass: nil)
      klass ||= HashStruct

      case obj
      when Array
        obj.map do |item|
          to_hash_struct(item, klass: klass)
        end.extend(ArrayHelper)
      when Hash
        klass.new.tap do |new_hash|
          obj.each do |key, value|
            new_hash[key.to_sym] = to_hash_struct(value, klass: klass)
          end
        end
      else
        obj
      end
    end

    def self.attribute(name, type, default: nil)
      attributes[name.to_sym] = type.new(default)
    end

    def self.attributes
      @attributes ||= {}
    end

    # @param hash [Hash]
    def initialize(hash = {})
      super()

      self.class.attributes.each do |key, type|
        send(:[]=, key, type.__value)
      end

      hash.each do |key, value|
        send(:[]=, key.to_sym, value)
      end if hash
    end

    def []=(key, value)
      type = self.class.attributes[key.to_sym]
      super(key.to_sym, self.class.to_hash_struct(type ? type.__value(value) : value, klass: type.class.respond_to?(:child_class) ? type.class.child_class : nil))
    end

    def [](key)
      key?(key) ? super : (key?(key.to_sym) ? super(key.to_sym) : super)
    end

    def method_missing(meth, *args)
      if meth.to_s.end_with?('=')
        send(:[]=, meth.to_s[/(.*)=$/, 1].to_sym, args.first)
      else
        fetch(meth.to_sym) { fetch(meth.to_s.tr('_', '-').to_sym, nil) }
      end
    end

    def respond_to_missing?(meth, _include_private = false)
      meth.to_s.end_with?('=') || key?(meth.to_sym) || key?(meth.to_s.tr('_', '-').to_sym) || super
    end

    # Removes empty and nil children
    def recursive_compact!
      K8s::Util.recursive_compact(self)
    end
  end
end
