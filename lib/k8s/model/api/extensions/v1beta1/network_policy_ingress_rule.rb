# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/network_policy_peer'
require 'k8s/model/api/extensions/v1beta1/network_policy_port'

module K8s::Model::Api::Extensions::V1beta1
  class NetworkPolicyIngressRule < K8s::TypedResource
    # List of sources which should be able to access the pods selected for this rule. Items in this list are combined using a logical OR operation. If this field is empty or missing, this rule matches all sources (traffic not restricted by source). If this field is present and contains at least on item, this rule allows traffic only if the traffic matches at least one item in the from list.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::NetworkPolicyPeer),NilClass]
    attribute :from, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::NetworkPolicyPeer).optional.default(nil)

    # List of ports which should be made accessible on the pods selected for this rule. Each item in this list is combined using a logical OR. If this field is empty or missing, this rule matches all ports (traffic not restricted by port). If this field is present and contains at least one item, then this rule allows traffic only if the traffic matches at least one port in the list.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::NetworkPolicyPort),NilClass]
    attribute :ports, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::NetworkPolicyPort).optional.default(nil)

    register_paths [
      
    ]
  end
end
