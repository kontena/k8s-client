# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta2"
require 'k8s/model/api/autoscaling/v2beta2/metric_target'

module K8s::Model::Api::Autoscaling::V2beta2
  class ResourceMetricSource < K8s::TypedResource
    # name is the name of the resource in question.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # target specifies the target value for the given metric
    # @return [K8s::Model::Api::Autoscaling::V2beta2::MetricTarget]
    attribute :target, K8s::Model::Api::Autoscaling::V2beta2::MetricTarget

    register_paths [
      
    ]
  end
end
