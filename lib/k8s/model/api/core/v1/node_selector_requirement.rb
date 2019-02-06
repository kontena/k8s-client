# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class NodeSelectorRequirement < K8s::TypedResource
    # The label key that the selector applies to.
    # @return [K8s::API::Types::String]
    attribute :key, K8s::API::Types::String

    # Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.
    # @return [K8s::API::Types::String]
    attribute :operator, K8s::API::Types::String

    # An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :values, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths [
      
    ]
  end
end
