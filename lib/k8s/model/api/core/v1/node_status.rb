# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_address'
require 'k8s/model/api/core/v1/node_condition'
require 'k8s/model/api/core/v1/node_config_status'
require 'k8s/model/api/core/v1/node_daemon_endpoints'
require 'k8s/model/api/core/v1/container_image'
require 'k8s/model/api/core/v1/node_system_info'
require 'k8s/model/api/core/v1/attached_volume'

module K8s::Model::Api::Core::V1
  class NodeStatus < K8s::TypedResource
    # List of addresses reachable to the node. Queried from cloud provider, if available. More info: https://kubernetes.io/docs/concepts/nodes/node/#addresses
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeAddress),NilClass]
    attribute :addresses, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeAddress).optional.default(nil)

    # Allocatable represents the resources of a node that are available for scheduling. Defaults to Capacity.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :allocatable, K8s::API::Types::Hash.optional.default(nil)

    # Capacity represents the total resources of a node. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :capacity, K8s::API::Types::Hash.optional.default(nil)

    # Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/concepts/nodes/node/#condition
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::NodeCondition).optional.default(nil)

    # Status of the config assigned to the node via the dynamic Kubelet config feature.
    # @return [K8s::Model::Api::Core::V1::NodeConfigStatus,NilClass]
    attribute :config, K8s::Model::Api::Core::V1::NodeConfigStatus.optional.default(nil)

    # Endpoints of daemons running on the Node.
    # @return [K8s::Model::Api::Core::V1::NodeDaemonEndpoints,NilClass]
    attribute :daemonEndpoints, K8s::Model::Api::Core::V1::NodeDaemonEndpoints.optional.default(nil)

    # List of container images on this node
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ContainerImage),NilClass]
    attribute :images, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ContainerImage).optional.default(nil)

    # Set of ids/uuids to uniquely identify the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#info
    # @return [K8s::Model::Api::Core::V1::NodeSystemInfo,NilClass]
    attribute :nodeInfo, K8s::Model::Api::Core::V1::NodeSystemInfo.optional.default(nil)

    # NodePhase is the recently observed lifecycle phase of the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#phase The field is never populated, and now is deprecated.
    # @return [K8s::API::Types::String,NilClass]
    attribute :phase, K8s::API::Types::String.optional.default(nil)

    # List of volumes that are attached to the node.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::AttachedVolume),NilClass]
    attribute :volumesAttached, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::AttachedVolume).optional.default(nil)

    # List of attachable volumes in use (mounted) by the node.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :volumesInUse, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths [
      
    ]
  end
end
