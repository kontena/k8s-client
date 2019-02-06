# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta2"
require 'k8s/model/api/autoscaling/v2beta2/cross_version_object_reference'
require 'k8s/model/api/autoscaling/v2beta2/metric_identifier'
require 'k8s/model/api/autoscaling/v2beta2/metric_target'

module K8s::Model::Api::Autoscaling::V2beta2
  class ObjectMetricSource < K8s::TypedResource
    # @return [K8s::Model::Api::Autoscaling::V2beta2::CrossVersionObjectReference]
    attribute :describedObject, K8s::Model::Api::Autoscaling::V2beta2::CrossVersionObjectReference

    # metric identifies the target metric by name and selector
    # @return [K8s::Model::Api::Autoscaling::V2beta2::MetricIdentifier]
    attribute :metric, K8s::Model::Api::Autoscaling::V2beta2::MetricIdentifier

    # target specifies the target value for the given metric
    # @return [K8s::Model::Api::Autoscaling::V2beta2::MetricTarget]
    attribute :target, K8s::Model::Api::Autoscaling::V2beta2::MetricTarget

    register_paths [
      
    ]
  end
end
