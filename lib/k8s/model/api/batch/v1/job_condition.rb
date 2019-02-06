# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/batch/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Batch::V1
  class JobCondition < K8s::TypedResource
    # Last time the condition was checked.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastProbeTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

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

    # Type of job condition, Complete or Failed.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
