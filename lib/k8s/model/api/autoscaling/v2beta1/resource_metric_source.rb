# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"
require 'k8s/model/apimachinery/api/resource/quantity'

module K8s::Model::Api::Autoscaling::V2beta1
  class ResourceMetricSource < K8s::TypedResource
    # name is the name of the resource in question.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # targetAverageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :targetAverageUtilization, K8s::API::Types::Integer.optional.default(nil)

    # targetAverageValue is the target value of the average of the resource metric across all relevant pods, as a raw value (instead of as a percentage of the request), similar to the "pods" metric source type.
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :targetAverageValue, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    register_paths [
      
    ]
  end
end
