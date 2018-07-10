module Pharos
  module Kube
    class Resource
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

      def [](attr)
        @attrs[attr]
      end
    end
  end
end
