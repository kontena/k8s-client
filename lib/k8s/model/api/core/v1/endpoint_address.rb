# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/object_reference'

module K8s::Model::Api::Core::V1
  class EndpointAddress < K8s::TypedResource
    # The Hostname of this endpoint
    # @return [K8s::API::Types::String,NilClass]
    attribute :hostname, K8s::API::Types::String.optional.default(nil)

    # The IP of this endpoint. May not be loopback (127.0.0.0/8), link-local (169.254.0.0/16), or link-local multicast ((224.0.0.0/24). IPv6 is also accepted but not fully supported on all platforms. Also, certain kubernetes components, like kube-proxy, are not IPv6 ready.
    # @return [K8s::API::Types::String]
    attribute :ip, K8s::API::Types::String

    # Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node.
    # @return [K8s::API::Types::String,NilClass]
    attribute :nodeName, K8s::API::Types::String.optional.default(nil)

    # Reference to object providing the endpoint.
    # @return [K8s::Model::Api::Core::V1::ObjectReference,NilClass]
    attribute :targetRef, K8s::Model::Api::Core::V1::ObjectReference.optional.default(nil)

    register_paths []
  end
end
