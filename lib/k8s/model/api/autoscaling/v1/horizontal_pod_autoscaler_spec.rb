# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v1"
require 'k8s/model/api/autoscaling/v1/cross_version_object_reference'

module K8s::Model::Api::Autoscaling::V1
  class HorizontalPodAutoscalerSpec < K8s::TypedResource
    # upper limit for the number of pods that can be set by the autoscaler; cannot be smaller than MinReplicas.
    # @return [K8s::API::Types::Integer]
    attribute :maxReplicas, K8s::API::Types::Integer

    # lower limit for the number of pods that can be set by the autoscaler, default 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minReplicas, K8s::API::Types::Integer.optional.default(nil)

    # reference to scaled resource; horizontal pod autoscaler will learn the current resource consumption and will set the desired number of pods by using its Scale subresource.
    # @return [K8s::Model::Api::Autoscaling::V1::CrossVersionObjectReference]
    attribute :scaleTargetRef, K8s::Model::Api::Autoscaling::V1::CrossVersionObjectReference

    # target average CPU utilization (represented as a percentage of requested CPU) over all the pods; if not specified the default autoscaling policy will be used.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :targetCPUUtilizationPercentage, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
