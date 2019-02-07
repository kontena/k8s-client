# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/batch/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'
require 'k8s/model/api/batch/v1/job_condition'

module K8s::Model::Api::Batch::V1
  class JobStatus < K8s::TypedResource
    # The number of actively running pods.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :active, K8s::API::Types::Integer.optional.default(nil)

    # Represents time when the job was completed. It is not guaranteed to be set in happens-before order across separate operations. It is represented in RFC3339 form and is in UTC.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :completionTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # The latest available observations of an object's current state. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Batch::V1::JobCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Batch::V1::JobCondition).optional.default(nil)

    # The number of pods which reached phase Failed.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :failed, K8s::API::Types::Integer.optional.default(nil)

    # Represents time when the job was acknowledged by the job controller. It is not guaranteed to be set in happens-before order across separate operations. It is represented in RFC3339 form and is in UTC.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :startTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # The number of pods which reached phase Succeeded.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :succeeded, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
