# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/local_object_reference'

module K8s::Model::Api::Core::V1
  class StorageOSVolumeSource < K8s::TypedResource
    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.
    # @return [K8s::Model::Api::Core::V1::LocalObjectReference,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::LocalObjectReference.optional.default(nil)

    # VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeName, K8s::API::Types::String.optional.default(nil)

    # VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeNamespace, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
