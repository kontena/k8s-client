# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/pod_affinity_term'

module K8s::Model::Api::Core::V1
  class WeightedPodAffinityTerm < K8s::TypedResource
    # Required. A pod affinity term, associated with the corresponding weight.
    # @return [K8s::Model::Api::Core::V1::PodAffinityTerm]
    attribute :podAffinityTerm, K8s::Model::Api::Core::V1::PodAffinityTerm

    # weight associated with matching the corresponding podAffinityTerm, in the range 1-100.
    # @return [K8s::API::Types::Integer]
    attribute :weight, K8s::API::Types::Integer

    register_paths [
      
    ]
  end
end
