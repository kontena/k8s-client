# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class APIResource < K8s::TypedResource
    # categories is a list of the grouped resources this resource belongs to (e.g. 'all')
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :categories, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # group is the preferred group of the resource.  Empty implies the group of the containing resource list. For subresources, this may have a different value, for example: Scale".
    # @return [K8s::API::Types::String,NilClass]
    attribute :group, K8s::API::Types::String.optional.default(nil)

    # kind is the kind for the resource (e.g. 'Foo' is the kind for a resource 'foo')
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # name is the plural name of the resource.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # namespaced indicates if a resource is namespaced or not.
    # @return [K8s::API::Types::Bool]
    attribute :namespaced, K8s::API::Types::Bool

    # shortNames is a list of suggested short names of the resource.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :shortNames, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # singularName is the singular name of the resource.  This allows clients to handle plural and singular opaquely. The singularName is more correct for reporting status on a single item and both singular and plural are allowed from the kubectl CLI interface.
    # @return [K8s::API::Types::String]
    attribute :singularName, K8s::API::Types::String

    # verbs is a list of supported kube verbs (this includes get, list, watch, create, update, patch, delete, deletecollection, and proxy)
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :verbs, K8s::API::Types::Array.of(K8s::API::Types::String)

    # version is the preferred version of the resource.  Empty implies the version of the containing resource list For subresources, this may have a different value, for example: v1 (while inside a v1beta1 version of the core resource's group)".
    # @return [K8s::API::Types::String,NilClass]
    attribute :version, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
