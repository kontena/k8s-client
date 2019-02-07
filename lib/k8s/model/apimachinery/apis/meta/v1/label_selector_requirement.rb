# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class LabelSelectorRequirement < K8s::TypedResource
    # key is the label key that the selector applies to.
    # @return [K8s::API::Types::String]
    attribute :key, K8s::API::Types::String

    # operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
    # @return [K8s::API::Types::String]
    attribute :operator, K8s::API::Types::String

    # values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :values, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths []
  end
end
