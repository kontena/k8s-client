# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class FCVolumeSource < K8s::TypedResource
    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Optional: FC target lun number
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :lun, K8s::API::Types::Integer.optional.default(nil)

    # Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Optional: FC target worldwide names (WWNs)
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :targetWWNs, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :wwids, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths [
      
    ]
  end
end
