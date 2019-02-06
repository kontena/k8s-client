# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class PortworxVolumeSource < K8s::TypedResource
    # FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # VolumeID uniquely identifies a Portworx volume
    # @return [K8s::API::Types::String]
    attribute :volumeID, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
