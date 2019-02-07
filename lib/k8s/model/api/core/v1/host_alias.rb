# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class HostAlias < K8s::TypedResource
    # Hostnames for the above IP address.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :hostnames, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # IP address of the host file entry.
    # @return [K8s::API::Types::String,NilClass]
    attribute :ip, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
