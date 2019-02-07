# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/http_ingress_path'

module K8s::Model::Api::Extensions::V1beta1
  class HTTPIngressRuleValue < K8s::TypedResource
    # A collection of paths that map requests to backends.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::HTTPIngressPath)]
    attribute :paths, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::HTTPIngressPath)

    register_paths []
  end
end
