# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class EndpointPort < K8s::TypedResource
    # The name of this port (corresponds to ServicePort.Name). Must be a DNS_LABEL. Optional only if one port is defined.
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # The port number of the endpoint.
    # @return [K8s::API::Types::Integer]
    attribute :port, K8s::API::Types::Integer

    # The IP protocol for this port. Must be UDP, TCP, or SCTP. Default is TCP.
    # @return [K8s::API::Types::String,NilClass]
    attribute :protocol, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
