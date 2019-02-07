# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/key_to_path'

module K8s::Model::Api::Core::V1
  class SecretProjection < K8s::TypedResource
    # If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::KeyToPath),NilClass]
    attribute :items, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::KeyToPath).optional.default(nil)

    # Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # Specify whether the Secret or its key must be defined
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :optional, K8s::API::Types::Bool.optional.default(nil)

    register_paths []
  end
end
