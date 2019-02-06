# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/config_map_env_source'
require 'k8s/model/api/core/v1/secret_env_source'

module K8s::Model::Api::Core::V1
  class EnvFromSource < K8s::TypedResource
    # The ConfigMap to select from
    # @return [K8s::Model::Api::Core::V1::ConfigMapEnvSource,NilClass]
    attribute :configMapRef, K8s::Model::Api::Core::V1::ConfigMapEnvSource.optional.default(nil)

    # An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER.
    # @return [K8s::API::Types::String,NilClass]
    attribute :prefix, K8s::API::Types::String.optional.default(nil)

    # The Secret to select from
    # @return [K8s::Model::Api::Core::V1::SecretEnvSource,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::SecretEnvSource.optional.default(nil)

    register_paths [
      
    ]
  end
end
