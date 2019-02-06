# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/batch/v1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/batch/v1/job_spec'
require 'k8s/model/api/batch/v1/job_status'

module K8s::Model::Api::Batch::V1
  class Job < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Specification of the desired behavior of a job. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::Model::Api::Batch::V1::JobSpec,NilClass]
    attribute :spec, K8s::Model::Api::Batch::V1::JobSpec.optional.default(nil)

    # Current status of a job. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::Model::Api::Batch::V1::JobStatus,NilClass]
    attribute :status, K8s::Model::Api::Batch::V1::JobStatus.optional.default(nil)

    register_paths [
      '/apis/batch/v1/namespaces/{namespace}/jobs/{name}',
      '/apis/batch/v1/namespaces/{namespace}/jobs/{name}/status'
    ]
  end
end
