# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/weighted_pod_affinity_term'
require 'k8s/model/api/core/v1/pod_affinity_term'

module K8s::Model::Api::Core::V1
  class PodAntiAffinity < K8s::TypedResource
    # The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding "weight" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::WeightedPodAffinityTerm),NilClass]
    attribute :preferredDuringSchedulingIgnoredDuringExecution, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::WeightedPodAffinityTerm).optional.default(nil)

    # If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PodAffinityTerm),NilClass]
    attribute :requiredDuringSchedulingIgnoredDuringExecution, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PodAffinityTerm).optional.default(nil)

    register_paths []
  end
end
