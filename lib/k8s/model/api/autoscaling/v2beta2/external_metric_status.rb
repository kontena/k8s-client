# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta2"
require 'k8s/model/api/autoscaling/v2beta2/metric_value_status'
require 'k8s/model/api/autoscaling/v2beta2/metric_identifier'

module K8s::Model::Api::Autoscaling::V2beta2
  class ExternalMetricStatus < K8s::TypedResource
    # current contains the current value for the given metric
    # @return [K8s::Model::Api::Autoscaling::V2beta2::MetricValueStatus]
    attribute :current, K8s::Model::Api::Autoscaling::V2beta2::MetricValueStatus

    # metric identifies the target metric by name and selector
    # @return [K8s::Model::Api::Autoscaling::V2beta2::MetricIdentifier]
    attribute :metric, K8s::Model::Api::Autoscaling::V2beta2::MetricIdentifier

    register_paths []
  end
end
