# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/policy/v1beta1"


module K8s::Model::Api::Policy::V1beta1
  class PodDisruptionBudgetStatus < K8s::TypedResource
    # current number of healthy pods
    # @return [K8s::API::Types::Integer]
    attribute :currentHealthy, K8s::API::Types::Integer

    # minimum desired number of healthy pods
    # @return [K8s::API::Types::Integer]
    attribute :desiredHealthy, K8s::API::Types::Integer

    # DisruptedPods contains information about pods whose eviction was processed by the API server eviction subresource handler but has not yet been observed by the PodDisruptionBudget controller. A pod will be in this map from the time when the API server processed the eviction request to the time when the pod is seen by PDB controller as having been marked for deletion (or after a timeout). The key in the map is the name of the pod and the value is the time when the API server processed the eviction request. If the deletion didn't occur and a pod is still there it will be removed from the list automatically by PodDisruptionBudget controller after some time. If everything goes smooth this map should be empty for the most of the time. Large number of entries in the map may indicate problems with pod deletions.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :disruptedPods, K8s::API::Types::Hash.optional.default(nil)

    # Number of pod disruptions that are currently allowed.
    # @return [K8s::API::Types::Integer]
    attribute :disruptionsAllowed, K8s::API::Types::Integer

    # total number of pods counted by this disruption budget
    # @return [K8s::API::Types::Integer]
    attribute :expectedPods, K8s::API::Types::Integer

    # Most recent generation observed when updating this PDB status. PodDisruptionsAllowed and other status informatio is valid only if observedGeneration equals to PDB's object generation.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
