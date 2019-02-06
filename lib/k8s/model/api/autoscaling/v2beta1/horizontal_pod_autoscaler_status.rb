# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"
require 'k8s/model/api/autoscaling/v2beta1/horizontal_pod_autoscaler_condition'
require 'k8s/model/api/autoscaling/v2beta1/metric_status'
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Autoscaling::V2beta1
  class HorizontalPodAutoscalerStatus < K8s::TypedResource
    # conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Autoscaling::V2beta1::HorizontalPodAutoscalerCondition)]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Autoscaling::V2beta1::HorizontalPodAutoscalerCondition)

    # currentMetrics is the last read state of the metrics used by this autoscaler.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Autoscaling::V2beta1::MetricStatus),NilClass]
    attribute :currentMetrics, K8s::API::Types::Array.of(K8s::Model::Api::Autoscaling::V2beta1::MetricStatus).optional.default(nil)

    # currentReplicas is current number of replicas of pods managed by this autoscaler, as last seen by the autoscaler.
    # @return [K8s::API::Types::Integer]
    attribute :currentReplicas, K8s::API::Types::Integer

    # desiredReplicas is the desired number of replicas of pods managed by this autoscaler, as last calculated by the autoscaler.
    # @return [K8s::API::Types::Integer]
    attribute :desiredReplicas, K8s::API::Types::Integer

    # lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods, used by the autoscaler to control how often the number of pods is changed.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastScaleTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # observedGeneration is the most recent generation observed by this autoscaler.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
