# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Core::V1
  class ContainerStateTerminated < K8s::TypedResource
    # Container's ID in the format 'docker://<container_id>'
    # @return [K8s::API::Types::String,NilClass]
    attribute :containerID, K8s::API::Types::String.optional.default(nil)

    # Exit status from the last termination of the container
    # @return [K8s::API::Types::Integer]
    attribute :exitCode, K8s::API::Types::Integer

    # Time at which the container last terminated
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :finishedAt, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Message regarding the last termination of the container
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # (brief) reason from the last termination of the container
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # Signal from the last termination of the container
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :signal, K8s::API::Types::Integer.optional.default(nil)

    # Time at which previous execution of the container started
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :startedAt, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    register_paths []
  end
end
