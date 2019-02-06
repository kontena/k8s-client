# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1beta1"


module K8s::Model::Api::Authorization::V1beta1
  class ResourceAttributes < K8s::TypedResource
    # Group is the API Group of the Resource.  "*" means all.
    # @return [K8s::API::Types::String,NilClass]
    attribute :group, K8s::API::Types::String.optional.default(nil)

    # Name is the name of the resource being requested for a "get" or deleted for a "delete". "" (empty) means all.
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # Namespace is the namespace of the action being requested.  Currently, there is no distinction between no namespace and all namespaces "" (empty) is defaulted for LocalSubjectAccessReviews "" (empty) is empty for cluster-scoped resources "" (empty) means "all" for namespace scoped resources from a SubjectAccessReview or SelfSubjectAccessReview
    # @return [K8s::API::Types::String,NilClass]
    attribute :namespace, K8s::API::Types::String.optional.default(nil)

    # Resource is one of the existing resource types.  "*" means all.
    # @return [K8s::API::Types::String,NilClass]
    attribute :resource, K8s::API::Types::String.optional.default(nil)

    # Subresource is one of the existing resource types.  "" means none.
    # @return [K8s::API::Types::String,NilClass]
    attribute :subresource, K8s::API::Types::String.optional.default(nil)

    # Verb is a kubernetes resource API verb, like: get, list, watch, create, update, delete, proxy.  "*" means all.
    # @return [K8s::API::Types::String,NilClass]
    attribute :verb, K8s::API::Types::String.optional.default(nil)

    # Version is the API Version of the Resource.  "*" means all.
    # @return [K8s::API::Types::String,NilClass]
    attribute :version, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
