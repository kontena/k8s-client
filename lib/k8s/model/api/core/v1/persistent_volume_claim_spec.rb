# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/typed_local_object_reference'
require 'k8s/model/api/core/v1/resource_requirements'
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Core::V1
  class PersistentVolumeClaimSpec < K8s::TypedResource
    # AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :accessModes, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # This field requires the VolumeSnapshotDataSource alpha feature gate to be enabled and currently VolumeSnapshot is the only supported data source. If the provisioner can support VolumeSnapshot data source, it will create a new volume and data will be restored to the volume at the same time. If the provisioner does not support VolumeSnapshot data source, volume will not be created and the failure will be reported as an event. In the future, we plan to support more data source types and the behavior of the provisioner may change.
    # @return [K8s::Model::Api::Core::V1::TypedLocalObjectReference,NilClass]
    attribute :dataSource, K8s::Model::Api::Core::V1::TypedLocalObjectReference.optional.default(nil)

    # Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
    # @return [K8s::Model::Api::Core::V1::ResourceRequirements,NilClass]
    attribute :resources, K8s::Model::Api::Core::V1::ResourceRequirements.optional.default(nil)

    # A label query over volumes to consider for binding.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
    # @return [K8s::API::Types::String,NilClass]
    attribute :storageClassName, K8s::API::Types::String.optional.default(nil)

    # volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. This is a beta feature.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeMode, K8s::API::Types::String.optional.default(nil)

    # VolumeName is the binding reference to the PersistentVolume backing this claim.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeName, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
