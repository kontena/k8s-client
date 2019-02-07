# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class VolumeMount < K8s::TypedResource
    # Path within the container at which the volume should be mounted.  Must not contain ':'.
    # @return [K8s::API::Types::String]
    attribute :mountPath, K8s::API::Types::String

    # mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10.
    # @return [K8s::API::Types::String,NilClass]
    attribute :mountPropagation, K8s::API::Types::String.optional.default(nil)

    # This must match the Name of a Volume.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Path within the volume from which the container's volume should be mounted. Defaults to "" (volume's root).
    # @return [K8s::API::Types::String,NilClass]
    attribute :subPath, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
