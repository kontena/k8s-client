# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/ingress_backend'

module K8s::Model::Api::Extensions::V1beta1
  class HTTPIngressPath < K8s::TypedResource
    # Backend defines the referenced service endpoint to which the traffic will be forwarded to.
    # @return [K8s::Model::Api::Extensions::V1beta1::IngressBackend]
    attribute :backend, K8s::Model::Api::Extensions::V1beta1::IngressBackend

    # Path is an extended POSIX regex as defined by IEEE Std 1003.1, (i.e this follows the egrep/unix syntax, not the perl syntax) matched against the path of an incoming request. Currently it can contain characters disallowed from the conventional "path" part of a URL as defined by RFC 3986. Paths must begin with a '/'. If unspecified, the path defaults to a catch all sending traffic to the backend.
    # @return [K8s::API::Types::String,NilClass]
    attribute :path, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
