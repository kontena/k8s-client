# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/util/intstr/int_or_string'

module K8s::Model::Api::Core::V1
  class TCPSocketAction < K8s::TypedResource
    # Optional: Host name to connect to, defaults to the pod IP.
    # @return [K8s::API::Types::String,NilClass]
    attribute :host, K8s::API::Types::String.optional.default(nil)

    # Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString]
    attribute :port, K8s::Model::Apimachinery::Util::Intstr::IntOrString

    register_paths []
  end
end
