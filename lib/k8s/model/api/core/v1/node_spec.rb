# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_config_source'
require 'k8s/model/api/core/v1/taint'

module K8s::Model::Api::Core::V1
  class NodeSpec < K8s::TypedResource
    # If specified, the source to get node configuration from The DynamicKubeletConfig feature gate must be enabled for the Kubelet to use this field
    # @return [K8s::Model::Api::Core::V1::NodeConfigSource,NilClass]
    attribute :configSource, K8s::Model::Api::Core::V1::NodeConfigSource.optional.default(nil)

    # Deprecated. Not all kubelets will set this field. Remove field after 1.13. see: https://issues.k8s.io/61966
    # @return [K8s::API::Types::String,NilClass]
    attribute :externalID, K8s::API::Types::String.optional.default(nil)

    # PodCIDR represents the pod IP range assigned to the node.
    # @return [K8s::API::Types::String,NilClass]
    attribute :podCIDR, K8s::API::Types::String.optional.default(nil)

    # ID of the node assigned by the cloud provider in the format: <ProviderName>://<ProviderSpecificNodeID>
    # @return [K8s::API::Types::String,NilClass]
    attribute :providerID, K8s::API::Types::String.optional.default(nil)

    # If specified, the node's taints.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Taint),NilClass]
    attribute :taints, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Taint).optional.default(nil)

    # Unschedulable controls node schedulability of new pods. By default, node is schedulable. More info: https://kubernetes.io/docs/concepts/nodes/node/#manual-node-administration
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :unschedulable, K8s::API::Types::Bool.optional.default(nil)

    register_paths []
  end
end
