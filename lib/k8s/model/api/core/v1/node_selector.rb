# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_selector_term'

module K8s::Model::Api::Core::V1
  class NodeSelector < K8s::TypedResource
    # Required. A list of node selector terms. The terms are ORed.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeSelectorTerm)]
    attribute :nodeSelectorTerms, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeSelectorTerm)

    register_paths [
      
    ]
  end
end
