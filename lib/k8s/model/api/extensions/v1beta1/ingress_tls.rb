# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"


module K8s::Model::Api::Extensions::V1beta1
  class IngressTLS < K8s::TypedResource
    # Hosts are a list of hosts included in the TLS certificate. The values in this list must match the name/s used in the tlsSecret. Defaults to the wildcard host setting for the loadbalancer controller fulfilling this Ingress, if left unspecified.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :hosts, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # SecretName is the name of the secret used to terminate SSL traffic on 443. Field is left optional to allow SSL routing based on SNI hostname alone. If the SNI host in a listener conflicts with the "Host" header field used by an IngressRule, the SNI host is used for termination and value of the Host header is used for routing.
    # @return [K8s::API::Types::String,NilClass]
    attribute :secretName, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
