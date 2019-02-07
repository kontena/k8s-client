# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta2"
require 'k8s/model/apimachinery/api/resource/quantity'

module K8s::Model::Api::Autoscaling::V2beta2
  class MetricTarget < K8s::TypedResource
    # averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :averageUtilization, K8s::API::Types::Integer.optional.default(nil)

    # averageValue is the target value of the average of the metric across all relevant pods (as a quantity)
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :averageValue, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    # type represents whether the metric type is Utilization, Value, or AverageValue
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    # value is the target value of the metric (as a quantity).
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :value, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    register_paths []
  end
end
