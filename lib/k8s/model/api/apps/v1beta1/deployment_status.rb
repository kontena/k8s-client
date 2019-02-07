# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta1"
require 'k8s/model/api/apps/v1beta1/deployment_condition'

module K8s::Model::Api::Apps::V1beta1
  class DeploymentStatus < K8s::TypedResource
    # Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :availableReplicas, K8s::API::Types::Integer.optional.default(nil)

    # Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :collisionCount, K8s::API::Types::Integer.optional.default(nil)

    # Represents the latest available observations of a deployment's current state.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta1::DeploymentCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta1::DeploymentCondition).optional.default(nil)

    # The generation observed by the deployment controller.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    # Total number of ready pods targeted by this deployment.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :readyReplicas, K8s::API::Types::Integer.optional.default(nil)

    # Total number of non-terminated pods targeted by this deployment (their labels match the selector).
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :replicas, K8s::API::Types::Integer.optional.default(nil)

    # Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :unavailableReplicas, K8s::API::Types::Integer.optional.default(nil)

    # Total number of non-terminated pods targeted by this deployment that have the desired template spec.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :updatedReplicas, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
