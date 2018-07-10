module Pharos
  module Kube
    # generic untyped resource
    class Resource
      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        return new(**data)
      end

      # @param filename [String] file path
      # @return [self]
      def self.from_file(filename)
        return new(YAML.load_file(filename))
      end

      attr_reader :kind, :apiVersion, :metadata

      def initialize(**attrs)
        @kind = attrs[:kind]
        @apiVersion = attrs[:apiVersion]
        @metadata = Pharos::Kube::API::MetaV1::ObjectMeta.new(**attrs[:metadata])
        @attrs = attrs
      end

      def attrs
        @attrs
      end

      # @return [Hash]
      def to_hash
        @attrs
      end

      # @return [String]
      def to_json(**options)
        to_hash.to_json(**options)
      end

      def [](attr)
        @attrs[attr]
      end
    end
  end
end
