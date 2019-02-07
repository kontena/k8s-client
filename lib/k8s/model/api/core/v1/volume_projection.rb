# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/config_map_projection'
require 'k8s/model/api/core/v1/downward_api_projection'
require 'k8s/model/api/core/v1/secret_projection'
require 'k8s/model/api/core/v1/service_account_token_projection'

module K8s::Model::Api::Core::V1
  class VolumeProjection < K8s::TypedResource
    # information about the configMap data to project
    # @return [K8s::Model::Api::Core::V1::ConfigMapProjection,NilClass]
    attribute :configMap, K8s::Model::Api::Core::V1::ConfigMapProjection.optional.default(nil)

    # information about the downwardAPI data to project
    # @return [K8s::Model::Api::Core::V1::DownwardAPIProjection,NilClass]
    attribute :downwardAPI, K8s::Model::Api::Core::V1::DownwardAPIProjection.optional.default(nil)

    # information about the secret data to project
    # @return [K8s::Model::Api::Core::V1::SecretProjection,NilClass]
    attribute :secret, K8s::Model::Api::Core::V1::SecretProjection.optional.default(nil)

    # information about the serviceAccountToken data to project
    # @return [K8s::Model::Api::Core::V1::ServiceAccountTokenProjection,NilClass]
    attribute :serviceAccountToken, K8s::Model::Api::Core::V1::ServiceAccountTokenProjection.optional.default(nil)

    register_paths []
  end
end
