# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class LocalVolumeSource < K8s::TypedResource
    # Filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a fileystem if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # The full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).
    # @return [K8s::API::Types::String]
    attribute :path, K8s::API::Types::String

    register_paths []
  end
end
