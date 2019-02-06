# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/ingress_backend'
require 'k8s/model/api/extensions/v1beta1/ingress_rule'
require 'k8s/model/api/extensions/v1beta1/ingress_tls'

module K8s::Model::Api::Extensions::V1beta1
  class IngressSpec < K8s::TypedResource
    # A default backend capable of servicing requests that don't match any rule. At least one of 'backend' or 'rules' must be specified. This field is optional to allow the loadbalancer controller or defaulting logic to specify a global default.
    # @return [K8s::Model::Api::Extensions::V1beta1::IngressBackend,NilClass]
    attribute :backend, K8s::Model::Api::Extensions::V1beta1::IngressBackend.optional.default(nil)

    # A list of host rules used to configure the Ingress. If unspecified, or no rule matches, all traffic is sent to the default backend.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::IngressRule),NilClass]
    attribute :rules, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::IngressRule).optional.default(nil)

    # TLS configuration. Currently the Ingress only supports a single TLS port, 443. If multiple members of this list specify different hosts, they will be multiplexed on the same port according to the hostname specified through the SNI TLS extension, if the ingress controller fulfilling the ingress supports SNI.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::IngressTLS),NilClass]
    attribute :tls, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::IngressTLS).optional.default(nil)

    register_paths [
      
    ]
  end
end
