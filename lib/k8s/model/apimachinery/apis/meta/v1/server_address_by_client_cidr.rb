# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class ServerAddressByClientCIDR < K8s::TypedResource
    # The CIDR with which clients can match their IP to figure out the server address that they should use.
    # @return [K8s::API::Types::String]
    attribute :clientCIDR, K8s::API::Types::String

    # Address of this server, suitable for a client that matches the above CIDR. This can be a hostname, hostname:port, IP or IP:port.
    # @return [K8s::API::Types::String]
    attribute :serverAddress, K8s::API::Types::String

    register_paths []
  end
end
