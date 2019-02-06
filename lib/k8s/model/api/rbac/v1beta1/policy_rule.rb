# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/rbac/v1beta1"


module K8s::Model::Api::Rbac::V1beta1
  class PolicyRule < K8s::TypedResource
    # APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :apiGroups, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :nonResourceURLs, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :resourceNames, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Resources is a list of resources this rule applies to.  '*' represents all resources in the specified apiGroups. '*/foo' represents the subresource 'foo' for all resources in the specified apiGroups.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :resources, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Verbs is a list of Verbs that apply to ALL the ResourceKinds and AttributeRestrictions contained in this rule.  VerbAll represents all kinds.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :verbs, K8s::API::Types::Array.of(K8s::API::Types::String)

    register_paths [
      
    ]
  end
end
