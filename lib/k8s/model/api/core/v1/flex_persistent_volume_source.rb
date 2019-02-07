# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/secret_reference'

module K8s::Model::Api::Core::V1
  class FlexPersistentVolumeSource < K8s::TypedResource
    # Driver is the name of the driver to use for this volume.
    # @return [K8s::API::Types::String]
    attribute :driver, K8s::API::Types::String

    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Optional: Extra command options if any.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :options, K8s::API::Types::Hash.optional.default(nil)

    # Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    register_paths []
  end
end
