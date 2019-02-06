# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/secret_reference'

module K8s::Model::Api::Core::V1
  class CephFSPersistentVolumeSource < K8s::TypedResource
    # Required: Monitors is a collection of Ceph monitors More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :monitors, K8s::API::Types::Array.of(K8s::API::Types::String)

    # Optional: Used as the mounted root, rather than the full Ceph tree, default is /
    # @return [K8s::API::Types::String,NilClass]
    attribute :path, K8s::API::Types::String.optional.default(nil)

    # Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
    # @return [K8s::API::Types::String,NilClass]
    attribute :secretFile, K8s::API::Types::String.optional.default(nil)

    # Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    # Optional: User is the rados user name, default is admin More info: https://releases.k8s.io/HEAD/examples/volumes/cephfs/README.md#how-to-use-it
    # @return [K8s::API::Types::String,NilClass]
    attribute :user, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
