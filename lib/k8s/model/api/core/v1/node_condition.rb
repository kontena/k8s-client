# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Core::V1
  class NodeCondition < K8s::TypedResource
    # Last time we got an update on a given condition.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastHeartbeatTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Last time the condition transit from one status to another.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastTransitionTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Human readable message indicating details about last transition.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # (brief) reason for the condition's last transition.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # Status of the condition, one of True, False, Unknown.
    # @return [K8s::API::Types::String]
    attribute :status, K8s::API::Types::String

    # Type of node condition.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths []
  end
end
