# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_selector'

module K8s::Model::Api::Core::V1
  class VolumeNodeAffinity < K8s::TypedResource
    # Required specifies hard node constraints that must be met.
    # @return [K8s::Model::Api::Core::V1::NodeSelector,NilClass]
    attribute :required, K8s::Model::Api::Core::V1::NodeSelector.optional.default(nil)

    register_paths []
  end
end
