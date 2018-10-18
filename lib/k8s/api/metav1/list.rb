# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#ListMeta
      class ListMeta < Struct
        attribute :selfLink, Types::Strict::String.optional.default(nil)
        attribute :resourceVersion, Types::Strict::String.optional.default(nil)
        attribute :continue, Types::Strict::String.optional.default(nil)
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#List
      class List < Resource
        attribute :metadata, ListMeta
        attribute :items, Types::Strict::Array # untyped
      end
    end
  end
end
