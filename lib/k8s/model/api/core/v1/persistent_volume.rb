# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/core/v1/persistent_volume_spec'
require 'k8s/model/api/core/v1/persistent_volume_status'

module K8s::Model::Api::Core::V1
  class PersistentVolume < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec defines a specification of a persistent volume owned by the cluster. Provisioned by an administrator. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistent-volumes
    # @return [K8s::Model::Api::Core::V1::PersistentVolumeSpec,NilClass]
    attribute :spec, K8s::Model::Api::Core::V1::PersistentVolumeSpec.optional.default(nil)

    # Status represents the current information/status for the persistent volume. Populated by the system. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistent-volumes
    # @return [K8s::Model::Api::Core::V1::PersistentVolumeStatus,NilClass]
    attribute :status, K8s::Model::Api::Core::V1::PersistentVolumeStatus.optional.default(nil)

    register_paths [
      '/api/v1/persistentvolumes/{name}',
      '/api/v1/persistentvolumes/{name}/status'
    ]
  end
end
