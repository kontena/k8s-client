# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ConfigMapKeySelector < K8s::TypedResource
    # The key to select.
    # @return [K8s::API::Types::String]
    attribute :key, K8s::API::Types::String

    # Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # Specify whether the ConfigMap or it's key must be defined
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :optional, K8s::API::Types::Bool.optional.default(nil)

    register_paths [
      
    ]
  end
end
