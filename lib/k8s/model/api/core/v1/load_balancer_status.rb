# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/load_balancer_ingress'

module K8s::Model::Api::Core::V1
  class LoadBalancerStatus < K8s::TypedResource
    # Ingress is a list containing ingress points for the load-balancer. Traffic intended for the service should be sent to these ingress points.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::LoadBalancerIngress),NilClass]
    attribute :ingress, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::LoadBalancerIngress).optional.default(nil)

    register_paths [
      
    ]
  end
end
