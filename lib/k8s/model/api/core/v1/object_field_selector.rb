# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ObjectFieldSelector < K8s::TypedResource
    # Version of the schema the FieldPath is written in terms of, defaults to "v1".
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Path of the field to select in the specified API version.
    # @return [K8s::API::Types::String]
    attribute :fieldPath, K8s::API::Types::String

    register_paths []
  end
end
