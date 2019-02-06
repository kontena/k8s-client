# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_selector_term'

module K8s::Model::Api::Core::V1
  class PreferredSchedulingTerm < K8s::TypedResource
    # A node selector term, associated with the corresponding weight.
    # @return [K8s::Model::Api::Core::V1::NodeSelectorTerm]
    attribute :preference, K8s::Model::Api::Core::V1::NodeSelectorTerm

    # Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.
    # @return [K8s::API::Types::Integer]
    attribute :weight, K8s::API::Types::Integer

    register_paths [
      
    ]
  end
end
