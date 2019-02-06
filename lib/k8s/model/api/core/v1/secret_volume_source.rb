# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/key_to_path'

module K8s::Model::Api::Core::V1
  class SecretVolumeSource < K8s::TypedResource
    # Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :defaultMode, K8s::API::Types::Integer.optional.default(nil)

    # If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::KeyToPath),NilClass]
    attribute :items, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::KeyToPath).optional.default(nil)

    # Specify whether the Secret or it's keys must be defined
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :optional, K8s::API::Types::Bool.optional.default(nil)

    # Name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
    # @return [K8s::API::Types::String,NilClass]
    attribute :secretName, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
