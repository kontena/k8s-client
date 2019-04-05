# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIResource
      class APIResource < Struct
        attribute :name, Types::String
        attribute :singularName, Types::String
        attribute :namespaced, Types::Bool
        attribute :group, Types::String.optional.default(nil)
        attribute :version, Types::String.optional.default(nil)
        attribute :kind, Types::String
        attribute :verbs, Types::Array.of(Types::Strict::String)
        attribute :shortNames, Types::Array.of(Types::Strict::String).optional.default { [] }
        attribute :categories, Types::Array.of(Types::Strict::String).optional.default { [] }
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIResourceList
      class APIResourceList < Resource
        attribute :groupVersion, Types::String
        attribute :resources, Types::Array.of(APIResource)
      end
    end
  end
end
