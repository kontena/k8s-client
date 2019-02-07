# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/rbac/v1alpha1"


module K8s::Model::Api::Rbac::V1alpha1
  class RoleRef < K8s::TypedResource
    # APIGroup is the group for the resource being referenced
    # @return [K8s::API::Types::String]
    attribute :apiGroup, K8s::API::Types::String

    # Kind is the type of resource being referenced
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # Name is the name of resource being referenced
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    register_paths []
  end
end
