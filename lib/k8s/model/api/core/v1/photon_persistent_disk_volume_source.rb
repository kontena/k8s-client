# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class PhotonPersistentDiskVolumeSource < K8s::TypedResource
    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # ID that identifies Photon Controller persistent disk
    # @return [K8s::API::Types::String]
    attribute :pdID, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
