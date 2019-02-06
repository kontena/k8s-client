# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/batch/v1beta1"
require 'k8s/model/api/core/v1/object_reference'
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Batch::V1beta1
  class CronJobStatus < K8s::TypedResource
    # A list of pointers to currently running jobs.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ObjectReference),NilClass]
    attribute :active, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ObjectReference).optional.default(nil)

    # Information when was the last time the job was successfully scheduled.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastScheduleTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    register_paths [
      
    ]
  end
end
