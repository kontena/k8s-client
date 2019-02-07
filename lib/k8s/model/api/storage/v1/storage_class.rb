# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/storage/v1"
require 'k8s/model/api/core/v1/topology_selector_term'
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'

module K8s::Model::Api::Storage::V1
  class StorageClass < K8s::TypedResource
    # AllowVolumeExpansion shows whether the storage class allow volume expand
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :allowVolumeExpansion, K8s::API::Types::Bool.optional.default(nil)

    # Restrict the node topologies where volumes can be dynamically provisioned. Each volume plugin defines its own supported topology specifications. An empty TopologySelectorTerm list means there is no topology restriction. This field is only honored by servers that enable the VolumeScheduling feature.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::TopologySelectorTerm),NilClass]
    attribute :allowedTopologies, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::TopologySelectorTerm).optional.default(nil)

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Dynamically provisioned PersistentVolumes of this storage class are created with these mountOptions, e.g. ["ro", "soft"]. Not validated - mount of the PVs will simply fail if one is invalid.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :mountOptions, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Parameters holds the parameters for the provisioner that should create volumes of this storage class.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :parameters, K8s::API::Types::Hash.optional.default(nil)

    # Provisioner indicates the type of the provisioner.
    # @return [K8s::API::Types::String]
    attribute :provisioner, K8s::API::Types::String

    # Dynamically provisioned PersistentVolumes of this storage class are created with this reclaimPolicy. Defaults to Delete.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reclaimPolicy, K8s::API::Types::String.optional.default(nil)

    # VolumeBindingMode indicates how PersistentVolumeClaims should be provisioned and bound.  When unset, VolumeBindingImmediate is used. This field is only honored by servers that enable the VolumeScheduling feature.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeBindingMode, K8s::API::Types::String.optional.default(nil)

    register_paths ["/apis/storage.k8s.io/v1/storageclasses/{name}"]
  end
end
