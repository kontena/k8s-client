# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/scoped_resource_selector_requirement'

module K8s::Model::Api::Core::V1
  class ScopeSelector < K8s::TypedResource
    # A list of scope selector requirements by scope of the resources.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ScopedResourceSelectorRequirement),NilClass]
    attribute :matchExpressions, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ScopedResourceSelectorRequirement).optional.default(nil)

    register_paths []
  end
end
