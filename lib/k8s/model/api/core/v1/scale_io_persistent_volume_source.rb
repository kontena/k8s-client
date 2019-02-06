# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/secret_reference'

module K8s::Model::Api::Core::V1
  class ScaleIOPersistentVolumeSource < K8s::TypedResource
    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Default is "xfs"
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # The host address of the ScaleIO API Gateway.
    # @return [K8s::API::Types::String]
    attribute :gateway, K8s::API::Types::String

    # The name of the ScaleIO Protection Domain for the configured storage.
    # @return [K8s::API::Types::String,NilClass]
    attribute :protectionDomain, K8s::API::Types::String.optional.default(nil)

    # Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.
    # @return [K8s::Model::Api::Core::V1::SecretReference]
    attribute :secretRef, K8s::Model::Api::Core::V1::SecretReference

    # Flag to enable/disable SSL communication with Gateway, default false
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :sslEnabled, K8s::API::Types::Bool.optional.default(nil)

    # Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.
    # @return [K8s::API::Types::String,NilClass]
    attribute :storageMode, K8s::API::Types::String.optional.default(nil)

    # The ScaleIO Storage Pool associated with the protection domain.
    # @return [K8s::API::Types::String,NilClass]
    attribute :storagePool, K8s::API::Types::String.optional.default(nil)

    # The name of the storage system as configured in ScaleIO.
    # @return [K8s::API::Types::String]
    attribute :system, K8s::API::Types::String

    # The name of a volume already created in the ScaleIO system that is associated with this volume source.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeName, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
