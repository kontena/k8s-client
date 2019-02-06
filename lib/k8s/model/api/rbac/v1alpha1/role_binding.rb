# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/rbac/v1alpha1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/rbac/v1alpha1/role_ref'
require 'k8s/model/api/rbac/v1alpha1/subject'

module K8s::Model::Api::Rbac::V1alpha1
  class RoleBinding < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # RoleRef can reference a Role in the current namespace or a ClusterRole in the global namespace. If the RoleRef cannot be resolved, the Authorizer must return an error.
    # @return [K8s::Model::Api::Rbac::V1alpha1::RoleRef]
    attribute :roleRef, K8s::Model::Api::Rbac::V1alpha1::RoleRef

    # Subjects holds references to the objects the role applies to.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Rbac::V1alpha1::Subject),NilClass]
    attribute :subjects, K8s::API::Types::Array.of(K8s::Model::Api::Rbac::V1alpha1::Subject).optional.default(nil)

    register_paths [
      '/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings/{name}'
    ]
  end
end
