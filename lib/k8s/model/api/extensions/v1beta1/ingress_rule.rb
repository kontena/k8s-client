# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/http_ingress_rule_value'

module K8s::Model::Api::Extensions::V1beta1
  class IngressRule < K8s::TypedResource
    # Host is the fully qualified domain name of a network host, as defined by RFC 3986. Note the following deviations from the "host" part of the URI as defined in the RFC: 1. IPs are not allowed. Currently an IngressRuleValue can only apply to the

    # 	  IP in the Spec of the parent Ingress.

    # 2. The `:` delimiter is not respected because ports are not allowed.

    # 	  Currently the port of an Ingress is implicitly :80 for http and

    # 	  :443 for https.

    # Both these may change in the future. Incoming requests are matched against the host before the IngressRuleValue. If the host is unspecified, the Ingress routes all traffic based on the specified IngressRuleValue.
    # @return [K8s::API::Types::String,NilClass]
    attribute :host, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Api::Extensions::V1beta1::HTTPIngressRuleValue,NilClass]
    attribute :http, K8s::Model::Api::Extensions::V1beta1::HTTPIngressRuleValue.optional.default(nil)

    register_paths [
      
    ]
  end
end
