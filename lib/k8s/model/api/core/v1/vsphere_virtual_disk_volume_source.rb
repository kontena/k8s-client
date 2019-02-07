# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class VsphereVirtualDiskVolumeSource < K8s::TypedResource
    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.
    # @return [K8s::API::Types::String,NilClass]
    attribute :storagePolicyID, K8s::API::Types::String.optional.default(nil)

    # Storage Policy Based Management (SPBM) profile name.
    # @return [K8s::API::Types::String,NilClass]
    attribute :storagePolicyName, K8s::API::Types::String.optional.default(nil)

    # Path that identifies vSphere volume vmdk
    # @return [K8s::API::Types::String]
    attribute :volumePath, K8s::API::Types::String

    register_paths []
  end
end
