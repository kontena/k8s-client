# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"
require 'k8s/model/apimachinery/api/resource/quantity'
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/autoscaling/v2beta1/cross_version_object_reference'

module K8s::Model::Api::Autoscaling::V2beta1
  class ObjectMetricStatus < K8s::TypedResource
    # averageValue is the current value of the average of the metric across all relevant pods (as a quantity)
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :averageValue, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    # currentValue is the current value of the metric (as a quantity).
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity]
    attribute :currentValue, K8s::Model::Apimachinery::Api::Resource::Quantity

    # metricName is the name of the metric in question.
    # @return [K8s::API::Types::String]
    attribute :metricName, K8s::API::Types::String

    # selector is the string-encoded form of a standard kubernetes label selector for the given metric When set in the ObjectMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # target is the described Kubernetes object.
    # @return [K8s::Model::Api::Autoscaling::V2beta1::CrossVersionObjectReference]
    attribute :target, K8s::Model::Api::Autoscaling::V2beta1::CrossVersionObjectReference

    register_paths []
  end
end
