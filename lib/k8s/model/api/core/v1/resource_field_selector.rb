# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/api/resource/quantity'

module K8s::Model::Api::Core::V1
  class ResourceFieldSelector < K8s::TypedResource
    # Container name: required for volumes, optional for env vars
    # @return [K8s::API::Types::String,NilClass]
    attribute :containerName, K8s::API::Types::String.optional.default(nil)

    # Specifies the output format of the exposed resources, defaults to "1"
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :divisor, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    # Required: resource to select
    # @return [K8s::API::Types::String]
    attribute :resource, K8s::API::Types::String

    register_paths []
  end
end
