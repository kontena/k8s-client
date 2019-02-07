# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/networking/v1"
require 'k8s/model/api/networking/v1/network_policy_port'
require 'k8s/model/api/networking/v1/network_policy_peer'

module K8s::Model::Api::Networking::V1
  class NetworkPolicyEgressRule < K8s::TypedResource
    # List of destination ports for outgoing traffic. Each item in this list is combined using a logical OR. If this field is empty or missing, this rule matches all ports (traffic not restricted by port). If this field is present and contains at least one item, then this rule allows traffic only if the traffic matches at least one port in the list.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Networking::V1::NetworkPolicyPort),NilClass]
    attribute :ports, K8s::API::Types::Array.of(K8s::Model::Api::Networking::V1::NetworkPolicyPort).optional.default(nil)

    # List of destinations for outgoing traffic of pods selected for this rule. Items in this list are combined using a logical OR operation. If this field is empty or missing, this rule matches all destinations (traffic not restricted by destination). If this field is present and contains at least one item, this rule allows traffic only if the traffic matches at least one item in the to list.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Networking::V1::NetworkPolicyPeer),NilClass]
    attribute :to, K8s::API::Types::Array.of(K8s::Model::Api::Networking::V1::NetworkPolicyPeer).optional.default(nil)

    register_paths []
  end
end
