# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class TopologySelectorLabelRequirement < K8s::TypedResource
    # The label key that the selector applies to.
    # @return [K8s::API::Types::String]
    attribute :key, K8s::API::Types::String

    # An array of string values. One value must match the label to be selected. Each entry in Values is ORed.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :values, K8s::API::Types::Array.of(K8s::API::Types::String)

    register_paths [
      
    ]
  end
end
