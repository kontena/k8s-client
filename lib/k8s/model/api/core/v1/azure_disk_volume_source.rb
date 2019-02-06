# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class AzureDiskVolumeSource < K8s::TypedResource
    # Host Caching mode: None, Read Only, Read Write.
    # @return [K8s::API::Types::String,NilClass]
    attribute :cachingMode, K8s::API::Types::String.optional.default(nil)

    # The Name of the data disk in the blob storage
    # @return [K8s::API::Types::String]
    attribute :diskName, K8s::API::Types::String

    # The URI the data disk in the blob storage
    # @return [K8s::API::Types::String]
    attribute :diskURI, K8s::API::Types::String

    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Expected values Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    register_paths [
      
    ]
  end
end
