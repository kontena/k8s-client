# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class NodeSystemInfo < K8s::TypedResource
    # The Architecture reported by the node
    # @return [K8s::API::Types::String]
    attribute :architecture, K8s::API::Types::String

    # Boot ID reported by the node.
    # @return [K8s::API::Types::String]
    attribute :bootID, K8s::API::Types::String

    # ContainerRuntime Version reported by the node through runtime remote API (e.g. docker://1.5.0).
    # @return [K8s::API::Types::String]
    attribute :containerRuntimeVersion, K8s::API::Types::String

    # Kernel Version reported by the node from 'uname -r' (e.g. 3.16.0-0.bpo.4-amd64).
    # @return [K8s::API::Types::String]
    attribute :kernelVersion, K8s::API::Types::String

    # KubeProxy Version reported by the node.
    # @return [K8s::API::Types::String]
    attribute :kubeProxyVersion, K8s::API::Types::String

    # Kubelet Version reported by the node.
    # @return [K8s::API::Types::String]
    attribute :kubeletVersion, K8s::API::Types::String

    # MachineID reported by the node. For unique machine identification in the cluster this field is preferred. Learn more from man(5) machine-id: http://man7.org/linux/man-pages/man5/machine-id.5.html
    # @return [K8s::API::Types::String]
    attribute :machineID, K8s::API::Types::String

    # The Operating System reported by the node
    # @return [K8s::API::Types::String]
    attribute :operatingSystem, K8s::API::Types::String

    # OS Image reported by the node from /etc/os-release (e.g. Debian GNU/Linux 7 (wheezy)).
    # @return [K8s::API::Types::String]
    attribute :osImage, K8s::API::Types::String

    # SystemUUID reported by the node. For unique machine identification MachineID is preferred. This field is specific to Red Hat hosts https://access.redhat.com/documentation/en-US/Red_Hat_Subscription_Management/1/html/RHSM/getting-system-uuid.html
    # @return [K8s::API::Types::String]
    attribute :systemUUID, K8s::API::Types::String

    register_paths []
  end
end
