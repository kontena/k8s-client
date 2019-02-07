# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/persistent_volume_claim_condition'

module K8s::Model::Api::Core::V1
  class PersistentVolumeClaimStatus < K8s::TypedResource
    # AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :accessModes, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Represents the actual resources of the underlying volume.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :capacity, K8s::API::Types::Hash.optional.default(nil)

    # Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PersistentVolumeClaimCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PersistentVolumeClaimCondition).optional.default(nil)

    # Phase represents the current phase of PersistentVolumeClaim.
    # @return [K8s::API::Types::String,NilClass]
    attribute :phase, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
