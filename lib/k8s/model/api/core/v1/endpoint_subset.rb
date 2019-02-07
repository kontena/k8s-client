# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/endpoint_address'
require 'k8s/model/api/core/v1/endpoint_port'

module K8s::Model::Api::Core::V1
  class EndpointSubset < K8s::TypedResource
    # IP addresses which offer the related ports that are marked as ready. These endpoints should be considered safe for load balancers and clients to utilize.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EndpointAddress),NilClass]
    attribute :addresses, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EndpointAddress).optional.default(nil)

    # IP addresses which offer the related ports but are not currently marked as ready because they have not yet finished starting, have recently failed a readiness check, or have recently failed a liveness check.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EndpointAddress),NilClass]
    attribute :notReadyAddresses, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EndpointAddress).optional.default(nil)

    # Port numbers available on the related IP addresses.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EndpointPort),NilClass]
    attribute :ports, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EndpointPort).optional.default(nil)

    register_paths []
  end
end
