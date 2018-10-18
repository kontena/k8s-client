# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIResource
      class APIResource < Struct
        attribute :name, Types::Strict::String
        attribute :singularName, Types::Strict::String
        attribute :namespaced, Types::Strict::Bool
        attribute :group, Types::Strict::String.optional.default(nil)
        attribute :version, Types::Strict::String.optional.default(nil)
        attribute :kind, Types::Strict::String
        attribute :verbs, Types::Strict::Array.of(Types::Strict::String)
        attribute :shortNames, Types::Strict::Array.of(Types::Strict::String).optional.default([])
        attribute :categories, Types::Strict::Array.of(Types::Strict::String).optional.default([])
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIResourceList
      class APIResourceList < Resource
        attribute :groupVersion, Types::Strict::String
        attribute :resources, Types::Strict::Array.of(APIResource)
      end
    end
  end
end
