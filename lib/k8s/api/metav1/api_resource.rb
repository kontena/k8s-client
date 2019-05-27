# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIResource
      class APIResource < Struct
        attribute :name, K8s::Type::String
        attribute :singularName, K8s::Type::String
        attribute :namespaced, K8s::Type::Bool
        attribute :group, K8s::Type::String
        attribute :version, K8s::Type::String
        attribute :kind, K8s::Type::String
        attribute :verbs, K8s::Type::Array.of(K8s::Type::String), default: proc { [] }
        attribute :shortNames, K8s::Type::Array.of(K8s::Type::String), default: proc { [] }
        attribute :categories, K8s::Type::Array.of(K8s::Type::String), default: proc { [] }
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIResourceList
      class APIResourceList < Resource
        attribute :groupVersion, K8s::Type::String
        attribute :resources, K8s::Type::Array.of(APIResource)
      end
    end
  end
end
