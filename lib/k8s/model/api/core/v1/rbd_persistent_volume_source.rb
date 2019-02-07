# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/secret_reference'

module K8s::Model::Api::Core::V1
  class RBDPersistentVolumeSource < K8s::TypedResource
    # Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # The rados image name. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::API::Types::String]
    attribute :image, K8s::API::Types::String

    # Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::API::Types::String,NilClass]
    attribute :keyring, K8s::API::Types::String.optional.default(nil)

    # A collection of Ceph monitors. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :monitors, K8s::API::Types::Array.of(K8s::API::Types::String)

    # The rados pool name. Default is rbd. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::API::Types::String,NilClass]
    attribute :pool, K8s::API::Types::String.optional.default(nil)

    # ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    # The rados user name. Default is admin. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md#how-to-use-it
    # @return [K8s::API::Types::String,NilClass]
    attribute :user, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
