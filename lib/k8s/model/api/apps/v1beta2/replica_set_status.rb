# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/api/apps/v1beta2/replica_set_condition'

module K8s::Model::Api::Apps::V1beta2
  class ReplicaSetStatus < K8s::TypedResource
    # The number of available replicas (ready for at least minReadySeconds) for this replica set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :availableReplicas, K8s::API::Types::Integer.optional.default(nil)

    # Represents the latest available observations of a replica set's current state.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta2::ReplicaSetCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta2::ReplicaSetCondition).optional.default(nil)

    # The number of pods that have labels matching the labels of the pod template of the replicaset.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :fullyLabeledReplicas, K8s::API::Types::Integer.optional.default(nil)

    # ObservedGeneration reflects the generation of the most recently observed ReplicaSet.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    # The number of ready replicas for this replica set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :readyReplicas, K8s::API::Types::Integer.optional.default(nil)

    # Replicas is the most recently oberved number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller
    # @return [K8s::API::Types::Integer]
    attribute :replicas, K8s::API::Types::Integer

    register_paths []
  end
end
