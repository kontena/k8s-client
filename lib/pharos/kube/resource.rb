module Pharos
  module Kube
    # generic untyped resource
    class Resource
      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        return new(**data)
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
      def to_json
        to_hash.to_json
      end

      def [](attr)
        @attrs[attr]
      end
    end
  end
end
