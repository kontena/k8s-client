# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/http_header'
require 'k8s/model/apimachinery/util/intstr/int_or_string'

module K8s::Model::Api::Core::V1
  class HTTPGetAction < K8s::TypedResource
    # Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
    # @return [K8s::API::Types::String,NilClass]
    attribute :host, K8s::API::Types::String.optional.default(nil)

    # Custom headers to set in the request. HTTP allows repeated headers.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::HTTPHeader),NilClass]
    attribute :httpHeaders, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::HTTPHeader).optional.default(nil)

    # Path to access on the HTTP server.
    # @return [K8s::API::Types::String,NilClass]
    attribute :path, K8s::API::Types::String.optional.default(nil)

    # Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString]
    attribute :port, K8s::Model::Apimachinery::Util::Intstr::IntOrString

    # Scheme to use for connecting to the host. Defaults to HTTP.
    # @return [K8s::API::Types::String,NilClass]
    attribute :scheme, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
