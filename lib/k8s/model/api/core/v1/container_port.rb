# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ContainerPort < K8s::TypedResource
    # Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.
    # @return [K8s::API::Types::Integer]
    attribute :containerPort, K8s::API::Types::Integer

    # What host IP to bind the external port to.
    # @return [K8s::API::Types::String,NilClass]
    attribute :hostIP, K8s::API::Types::String.optional.default(nil)

    # Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :hostPort, K8s::API::Types::Integer.optional.default(nil)

    # If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # Protocol for port. Must be UDP, TCP, or SCTP. Defaults to "TCP".
    # @return [K8s::API::Types::String,NilClass]
    attribute :protocol, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
