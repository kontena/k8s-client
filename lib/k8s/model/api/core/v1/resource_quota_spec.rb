# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/scope_selector'

module K8s::Model::Api::Core::V1
  class ResourceQuotaSpec < K8s::TypedResource
    # hard is the set of desired hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :hard, K8s::API::Types::Hash.optional.default(nil)

    # scopeSelector is also a collection of filters like scopes that must match each object tracked by a quota but expressed using ScopeSelectorOperator in combination with possible values. For a resource to match, both scopes AND scopeSelector (if specified in spec), must be matched.
    # @return [K8s::Model::Api::Core::V1::ScopeSelector,NilClass]
    attribute :scopeSelector, K8s::Model::Api::Core::V1::ScopeSelector.optional.default(nil)

    # A collection of filters that must match each object tracked by a quota. If not specified, the quota matches all objects.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :scopes, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths []
  end
end
