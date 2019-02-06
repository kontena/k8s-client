# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/apimachinery/api/resource/quantity'

module K8s::Model::Api::Autoscaling::V2beta1
  class ExternalMetricSource < K8s::TypedResource
    # metricName is the name of the metric in question.
    # @return [K8s::API::Types::String]
    attribute :metricName, K8s::API::Types::String

    # metricSelector is used to identify a specific time series within a given metric.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :metricSelector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # targetAverageValue is the target per-pod value of global metric (as a quantity). Mutually exclusive with TargetValue.
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :targetAverageValue, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    # targetValue is the target value of the metric (as a quantity). Mutually exclusive with TargetAverageValue.
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :targetValue, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    register_paths [
      
    ]
  end
end
