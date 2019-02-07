# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/topology_selector_label_requirement'

module K8s::Model::Api::Core::V1
  class TopologySelectorTerm < K8s::TypedResource
    # A list of topology selector requirements by labels.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::TopologySelectorLabelRequirement),NilClass]
    attribute :matchLabelExpressions, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::TopologySelectorLabelRequirement).optional.default(nil)

    register_paths []
  end
end
