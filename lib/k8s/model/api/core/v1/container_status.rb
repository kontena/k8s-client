# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/container_state'

module K8s::Model::Api::Core::V1
  class ContainerStatus < K8s::TypedResource
    # Container's ID in the format 'docker://<container_id>'.
    # @return [K8s::API::Types::String,NilClass]
    attribute :containerID, K8s::API::Types::String.optional.default(nil)

    # The image the container is running. More info: https://kubernetes.io/docs/concepts/containers/images
    # @return [K8s::API::Types::String]
    attribute :image, K8s::API::Types::String

    # ImageID of the container's image.
    # @return [K8s::API::Types::String]
    attribute :imageID, K8s::API::Types::String

    # Details about the container's last termination condition.
    # @return [K8s::Model::Api::Core::V1::ContainerState,NilClass]
    attribute :lastState, K8s::Model::Api::Core::V1::ContainerState.optional.default(nil)

    # This must be a DNS_LABEL. Each container in a pod must have a unique name. Cannot be updated.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Specifies whether the container has passed its readiness probe.
    # @return [K8s::API::Types::Bool]
    attribute :ready, K8s::API::Types::Bool

    # The number of times the container has been restarted, currently based on the number of dead containers that have not yet been removed. Note that this is calculated from dead containers. But those containers are subject to garbage collection. This value will get capped at 5 by GC.
    # @return [K8s::API::Types::Integer]
    attribute :restartCount, K8s::API::Types::Integer

    # Details about the container's current condition.
    # @return [K8s::Model::Api::Core::V1::ContainerState,NilClass]
    attribute :state, K8s::Model::Api::Core::V1::ContainerState.optional.default(nil)

    register_paths [
      
    ]
  end
end
