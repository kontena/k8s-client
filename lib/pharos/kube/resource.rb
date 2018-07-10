module Pharos
  module Kube
    class Resource < Pharos::Kube::API::MetaV1::ObjectCommon
      def initialize(**attrs)
        super(
          kind: attrs[:kind],
          apiVersion: attrs[:apiVersion],
          metadata: attrs[:metadata],
        )
        @attrs = attrs
      end

      def [](attr)
        @attrs[attr]
      end
    end
  end
end
