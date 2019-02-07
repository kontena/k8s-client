# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/affinity'
require 'k8s/model/api/core/v1/container'
require 'k8s/model/api/core/v1/pod_dns_config'
require 'k8s/model/api/core/v1/host_alias'
require 'k8s/model/api/core/v1/local_object_reference'
require 'k8s/model/api/core/v1/pod_readiness_gate'
require 'k8s/model/api/core/v1/pod_security_context'
require 'k8s/model/api/core/v1/toleration'
require 'k8s/model/api/core/v1/volume'

module K8s::Model::Api::Core::V1
  class PodSpec < K8s::TypedResource
    # Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :activeDeadlineSeconds, K8s::API::Types::Integer.optional.default(nil)

    # If specified, the pod's scheduling constraints
    # @return [K8s::Model::Api::Core::V1::Affinity,NilClass]
    attribute :affinity, K8s::Model::Api::Core::V1::Affinity.optional.default(nil)

    # AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :automountServiceAccountToken, K8s::API::Types::Bool.optional.default(nil)

    # List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Container)]
    attribute :containers, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Container)

    # Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.
    # @return [K8s::Model::Api::Core::V1::PodDNSConfig,NilClass]
    attribute :dnsConfig, K8s::Model::Api::Core::V1::PodDNSConfig.optional.default(nil)

    # Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.
    # @return [K8s::API::Types::String,NilClass]
    attribute :dnsPolicy, K8s::API::Types::String.optional.default(nil)

    # EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :enableServiceLinks, K8s::API::Types::Bool.optional.default(nil)

    # HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::HostAlias),NilClass]
    attribute :hostAliases, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::HostAlias).optional.default(nil)

    # Use the host's ipc namespace. Optional: Default to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :hostIPC, K8s::API::Types::Bool.optional.default(nil)

    # Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :hostNetwork, K8s::API::Types::Bool.optional.default(nil)

    # Use the host's pid namespace. Optional: Default to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :hostPID, K8s::API::Types::Bool.optional.default(nil)

    # Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.
    # @return [K8s::API::Types::String,NilClass]
    attribute :hostname, K8s::API::Types::String.optional.default(nil)

    # ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::LocalObjectReference),NilClass]
    attribute :imagePullSecrets, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::LocalObjectReference).optional.default(nil)

    # List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, or Liveness probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Container),NilClass]
    attribute :initContainers, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Container).optional.default(nil)

    # NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements.
    # @return [K8s::API::Types::String,NilClass]
    attribute :nodeName, K8s::API::Types::String.optional.default(nil)

    # NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :nodeSelector, K8s::API::Types::Hash.optional.default(nil)

    # The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :priority, K8s::API::Types::Integer.optional.default(nil)

    # If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.
    # @return [K8s::API::Types::String,NilClass]
    attribute :priorityClassName, K8s::API::Types::String.optional.default(nil)

    # If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://github.com/kubernetes/community/blob/master/keps/sig-network/0007-pod-ready%2B%2B.md
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PodReadinessGate),NilClass]
    attribute :readinessGates, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PodReadinessGate).optional.default(nil)

    # Restart policy for all containers within the pod. One of Always, OnFailure, Never. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
    # @return [K8s::API::Types::String,NilClass]
    attribute :restartPolicy, K8s::API::Types::String.optional.default(nil)

    # RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://github.com/kubernetes/community/blob/master/keps/sig-node/0014-runtime-class.md This is an alpha feature and may change in the future.
    # @return [K8s::API::Types::String,NilClass]
    attribute :runtimeClassName, K8s::API::Types::String.optional.default(nil)

    # If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.
    # @return [K8s::API::Types::String,NilClass]
    attribute :schedulerName, K8s::API::Types::String.optional.default(nil)

    # SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.
    # @return [K8s::Model::Api::Core::V1::PodSecurityContext,NilClass]
    attribute :securityContext, K8s::Model::Api::Core::V1::PodSecurityContext.optional.default(nil)

    # DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.
    # @return [K8s::API::Types::String,NilClass]
    attribute :serviceAccount, K8s::API::Types::String.optional.default(nil)

    # ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
    # @return [K8s::API::Types::String,NilClass]
    attribute :serviceAccountName, K8s::API::Types::String.optional.default(nil)

    # Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. This field is beta-level and may be disabled with the PodShareProcessNamespace feature.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :shareProcessNamespace, K8s::API::Types::Bool.optional.default(nil)

    # If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.
    # @return [K8s::API::Types::String,NilClass]
    attribute :subdomain, K8s::API::Types::String.optional.default(nil)

    # Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :terminationGracePeriodSeconds, K8s::API::Types::Integer.optional.default(nil)

    # If specified, the pod's tolerations.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Toleration),NilClass]
    attribute :tolerations, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Toleration).optional.default(nil)

    # List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Volume),NilClass]
    attribute :volumes, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Volume).optional.default(nil)

    register_paths []
  end
end
