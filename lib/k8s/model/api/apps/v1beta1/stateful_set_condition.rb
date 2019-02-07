# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Apps::V1beta1
  class StatefulSetCondition < K8s::TypedResource
    # Last time the condition transitioned from one status to another.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastTransitionTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # A human readable message indicating details about the transition.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # The reason for the condition's last transition.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # Status of the condition, one of True, False, Unknown.
    # @return [K8s::API::Types::String]
    attribute :status, K8s::API::Types::String

    # Type of statefulset condition.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths []
  end
end
