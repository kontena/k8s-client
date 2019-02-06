# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1"


module K8s::Model::Api::Authorization::V1
  class ResourceRule < K8s::TypedResource
    # APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed.  "*" means all.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :apiGroups, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.  "*" means all.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :resourceNames, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Resources is a list of resources this rule applies to.  "*" means all in the specified apiGroups.

    #  "*/foo" represents the subresource 'foo' for all resources in the specified apiGroups.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :resources, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Verb is a list of kubernetes resource API verbs, like: get, list, watch, create, update, delete, proxy.  "*" means all.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :verbs, K8s::API::Types::Array.of(K8s::API::Types::String)

    register_paths [
      
    ]
  end
end
