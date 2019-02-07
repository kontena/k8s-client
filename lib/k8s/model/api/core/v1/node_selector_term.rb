# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_selector_requirement'

module K8s::Model::Api::Core::V1
  class NodeSelectorTerm < K8s::TypedResource
    # A list of node selector requirements by node's labels.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeSelectorRequirement),NilClass]
    attribute :matchExpressions, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeSelectorRequirement).optional.default(nil)

    # A list of node selector requirements by node's fields.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeSelectorRequirement),NilClass]
    attribute :matchFields, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeSelectorRequirement).optional.default(nil)

    register_paths []
  end
end
