# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/storage/v1alpha1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Storage::V1alpha1
  class VolumeError < K8s::TypedResource
    # String detailing the error encountered during Attach or Detach operation. This string maybe logged, so it should not contain sensitive information.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # Time the error was encountered.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :time, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    register_paths []
  end
end
