# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#ListMeta
      class ListMeta < Struct
        attribute :selfLink, K8s::Type::String
        attribute :resourceVersion, K8s::Type::String
        attribute :continue, K8s::Type::String
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#List
      class List < Resource
        attribute :metadata, ListMeta
        attribute :items, K8s::Type::Array
      end
    end
  end
end
