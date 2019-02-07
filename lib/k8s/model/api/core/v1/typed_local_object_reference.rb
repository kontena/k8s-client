# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class TypedLocalObjectReference < K8s::TypedResource
    # APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiGroup, K8s::API::Types::String.optional.default(nil)

    # Kind is the type of resource being referenced
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # Name is the name of resource being referenced
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    register_paths []
  end
end
