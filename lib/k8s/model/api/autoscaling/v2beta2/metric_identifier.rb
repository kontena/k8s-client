# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta2"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Autoscaling::V2beta2
  class MetricIdentifier < K8s::TypedResource
    # name is the name of the given metric
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    register_paths []
  end
end
