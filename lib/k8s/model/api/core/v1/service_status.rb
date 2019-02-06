# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/load_balancer_status'

module K8s::Model::Api::Core::V1
  class ServiceStatus < K8s::TypedResource
    # LoadBalancer contains the current status of the load-balancer, if one is present.
    # @return [K8s::Model::Api::Core::V1::LoadBalancerStatus,NilClass]
    attribute :loadBalancer, K8s::Model::Api::Core::V1::LoadBalancerStatus.optional.default(nil)

    register_paths [
      
    ]
  end
end
