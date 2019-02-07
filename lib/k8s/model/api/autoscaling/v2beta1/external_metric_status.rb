# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"
require 'k8s/model/apimachinery/api/resource/quantity'
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Autoscaling::V2beta1
  class ExternalMetricStatus < K8s::TypedResource
    # currentAverageValue is the current value of metric averaged over autoscaled pods.
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :currentAverageValue, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    # currentValue is the current value of the metric (as a quantity)
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity]
    attribute :currentValue, K8s::Model::Apimachinery::Api::Resource::Quantity

    # metricName is the name of a metric used for autoscaling in metric system.
    # @return [K8s::API::Types::String]
    attribute :metricName, K8s::API::Types::String

    # metricSelector is used to identify a specific time series within a given metric.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :metricSelector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    register_paths []
  end
end
