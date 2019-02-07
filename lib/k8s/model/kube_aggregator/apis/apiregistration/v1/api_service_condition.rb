# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/kube_aggregator/apis/apiregistration/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::KubeAggregator::Apis::Apiregistration::V1
  class APIServiceCondition < K8s::TypedResource
    # Last time the condition transitioned from one status to another.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastTransitionTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Human-readable message indicating details about last transition.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # Unique, one-word, CamelCase reason for the condition's last transition.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # Status is the status of the condition. Can be True, False, Unknown.
    # @return [K8s::API::Types::String]
    attribute :status, K8s::API::Types::String

    # Type is the type of the condition.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths []
  end
end
