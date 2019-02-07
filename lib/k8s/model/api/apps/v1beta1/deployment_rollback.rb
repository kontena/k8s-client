# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta1"
require 'k8s/model/api/apps/v1beta1/rollback_config'

module K8s::Model::Api::Apps::V1beta1
  class DeploymentRollback < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Required: This must match the Name of a deployment.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # The config of this deployment rollback.
    # @return [K8s::Model::Api::Apps::V1beta1::RollbackConfig]
    attribute :rollbackTo, K8s::Model::Api::Apps::V1beta1::RollbackConfig

    # The annotations to be updated to a deployment
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :updatedAnnotations, K8s::API::Types::Hash.optional.default(nil)

    register_paths []
  end
end
