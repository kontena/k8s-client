# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/secret_reference'

module K8s::Model::Api::Core::V1
  class CinderPersistentVolumeSource < K8s::TypedResource
    # Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Optional: points to a secret object containing parameters used to connect to OpenStack.
    # @return [K8s::Model::Api::Core::V1::SecretReference,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::SecretReference.optional.default(nil)

    # volume id used to identify the volume in cinder More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
    # @return [K8s::API::Types::String]
    attribute :volumeID, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
