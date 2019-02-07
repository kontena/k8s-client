# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/container_state_running'
require 'k8s/model/api/core/v1/container_state_terminated'
require 'k8s/model/api/core/v1/container_state_waiting'

module K8s::Model::Api::Core::V1
  class ContainerState < K8s::TypedResource
    # Details about a running container
    # @return [K8s::Model::Api::Core::V1::ContainerStateRunning,NilClass]
    attribute :running, K8s::Model::Api::Core::V1::ContainerStateRunning.optional.default(nil)

    # Details about a terminated container
    # @return [K8s::Model::Api::Core::V1::ContainerStateTerminated,NilClass]
    attribute :terminated, K8s::Model::Api::Core::V1::ContainerStateTerminated.optional.default(nil)

    # Details about a waiting container
    # @return [K8s::Model::Api::Core::V1::ContainerStateWaiting,NilClass]
    attribute :waiting, K8s::Model::Api::Core::V1::ContainerStateWaiting.optional.default(nil)

    register_paths []
  end
end
