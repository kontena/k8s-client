# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta2"
require 'k8s/model/api/autoscaling/v2beta2/metric_spec'
require 'k8s/model/api/autoscaling/v2beta2/cross_version_object_reference'

module K8s::Model::Api::Autoscaling::V2beta2
  class HorizontalPodAutoscalerSpec < K8s::TypedResource
    # maxReplicas is the upper limit for the number of replicas to which the autoscaler can scale up. It cannot be less that minReplicas.
    # @return [K8s::API::Types::Integer]
    attribute :maxReplicas, K8s::API::Types::Integer

    # metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond. If not set, the default metric will be set to 80% average CPU utilization.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Autoscaling::V2beta2::MetricSpec),NilClass]
    attribute :metrics, K8s::API::Types::Array.of(K8s::Model::Api::Autoscaling::V2beta2::MetricSpec).optional.default(nil)

    # minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down. It defaults to 1 pod.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minReplicas, K8s::API::Types::Integer.optional.default(nil)

    # scaleTargetRef points to the target resource to scale, and is used to the pods for which metrics should be collected, as well as to actually change the replica count.
    # @return [K8s::Model::Api::Autoscaling::V2beta2::CrossVersionObjectReference]
    attribute :scaleTargetRef, K8s::Model::Api::Autoscaling::V2beta2::CrossVersionObjectReference

    register_paths [
      
    ]
  end
end
