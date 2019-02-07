# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/secret_reference'

module K8s::Model::Api::Core::V1
  class CSIPersistentVolumeSource < K8s::TypedResource
    # ControllerPublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerPublishVolume and ControllerUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :controllerPublishSecretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    # Driver is the name of the driver to use for this volume. Required.
    # @return [K8s::API::Types::String]
    attribute :driver, K8s::API::Types::String

    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs".
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :nodePublishSecretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    # NodeStageSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeStageVolume and NodeStageVolume and NodeUnstageVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :nodeStageSecretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    # Optional: The value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write).
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Attributes of the volume to publish.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :volumeAttributes, K8s::API::Types::Hash.optional.default(nil)

    # VolumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required.
    # @return [K8s::API::Types::String]
    attribute :volumeHandle, K8s::API::Types::String

    register_paths []
  end
end
