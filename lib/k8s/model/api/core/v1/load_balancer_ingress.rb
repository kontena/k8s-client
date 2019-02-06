# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class LoadBalancerIngress < K8s::TypedResource
    # Hostname is set for load-balancer ingress points that are DNS based (typically AWS load-balancers)
    # @return [K8s::API::Types::String,NilClass]
    attribute :hostname, K8s::API::Types::String.optional.default(nil)

    # IP is set for load-balancer ingress points that are IP based (typically GCE or OpenStack load-balancers)
    # @return [K8s::API::Types::String,NilClass]
    attribute :ip, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
