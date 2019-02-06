# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Autoscaling::V1
  class HorizontalPodAutoscalerStatus < K8s::TypedResource
    # current average CPU utilization over all pods, represented as a percentage of requested CPU, e.g. 70 means that an average pod is using now 70% of its requested CPU.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :currentCPUUtilizationPercentage, K8s::API::Types::Integer.optional.default(nil)

    # current number of replicas of pods managed by this autoscaler.
    # @return [K8s::API::Types::Integer]
    attribute :currentReplicas, K8s::API::Types::Integer

    # desired number of replicas of pods managed by this autoscaler.
    # @return [K8s::API::Types::Integer]
    attribute :desiredReplicas, K8s::API::Types::Integer

    # last time the HorizontalPodAutoscaler scaled the number of pods; used by the autoscaler to control how often the number of pods is changed.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastScaleTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # most recent generation observed by this autoscaler.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
