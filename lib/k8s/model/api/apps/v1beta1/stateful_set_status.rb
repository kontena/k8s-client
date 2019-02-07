# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta1"
require 'k8s/model/api/apps/v1beta1/stateful_set_condition'

module K8s::Model::Api::Apps::V1beta1
  class StatefulSetStatus < K8s::TypedResource
    # collisionCount is the count of hash collisions for the StatefulSet. The StatefulSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :collisionCount, K8s::API::Types::Integer.optional.default(nil)

    # Represents the latest available observations of a statefulset's current state.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta1::StatefulSetCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta1::StatefulSetCondition).optional.default(nil)

    # currentReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :currentReplicas, K8s::API::Types::Integer.optional.default(nil)

    # currentRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [0,currentReplicas).
    # @return [K8s::API::Types::String,NilClass]
    attribute :currentRevision, K8s::API::Types::String.optional.default(nil)

    # observedGeneration is the most recent generation observed for this StatefulSet. It corresponds to the StatefulSet's generation, which is updated on mutation by the API Server.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    # readyReplicas is the number of Pods created by the StatefulSet controller that have a Ready Condition.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :readyReplicas, K8s::API::Types::Integer.optional.default(nil)

    # replicas is the number of Pods created by the StatefulSet controller.
    # @return [K8s::API::Types::Integer]
    attribute :replicas, K8s::API::Types::Integer

    # updateRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [replicas-updatedReplicas,replicas)
    # @return [K8s::API::Types::String,NilClass]
    attribute :updateRevision, K8s::API::Types::String.optional.default(nil)

    # updatedReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :updatedReplicas, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
