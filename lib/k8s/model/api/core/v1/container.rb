# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/env_var'
require 'k8s/model/api/core/v1/env_from_source'
require 'k8s/model/api/core/v1/lifecycle'
require 'k8s/model/api/core/v1/probe'
require 'k8s/model/api/core/v1/container_port'
require 'k8s/model/api/core/v1/resource_requirements'
require 'k8s/model/api/core/v1/security_context'
require 'k8s/model/api/core/v1/volume_device'
require 'k8s/model/api/core/v1/volume_mount'

module K8s::Model::Api::Core::V1
  class Container < K8s::TypedResource
    # Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :args, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :command, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # List of environment variables to set in the container. Cannot be updated.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvVar),NilClass]
    attribute :env, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvVar).optional.default(nil)

    # List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvFromSource),NilClass]
    attribute :envFrom, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvFromSource).optional.default(nil)

    # Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets.
    # @return [K8s::API::Types::String,NilClass]
    attribute :image, K8s::API::Types::String.optional.default(nil)

    # Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
    # @return [K8s::API::Types::String,NilClass]
    attribute :imagePullPolicy, K8s::API::Types::String.optional.default(nil)

    # Actions that the management system should take in response to container lifecycle events. Cannot be updated.
    # @return [K8s::Model::Api::Core::V1::Lifecycle,NilClass]
    attribute :lifecycle, K8s::Model::Api::Core::V1::Lifecycle.optional.default(nil)

    # Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    # @return [K8s::Model::Api::Core::V1::Probe,NilClass]
    attribute :livenessProbe, K8s::Model::Api::Core::V1::Probe.optional.default(nil)

    # Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default "0.0.0.0" address inside a container will be accessible from the network. Cannot be updated.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ContainerPort),NilClass]
    attribute :ports, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::ContainerPort).optional.default(nil)

    # Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    # @return [K8s::Model::Api::Core::V1::Probe,NilClass]
    attribute :readinessProbe, K8s::Model::Api::Core::V1::Probe.optional.default(nil)

    # Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
    # @return [K8s::Model::Api::Core::V1::ResourceRequirements,NilClass]
    attribute :resources, K8s::Model::Api::Core::V1::ResourceRequirements.optional.default(nil)

    # Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
    # @return [K8s::Model::Api::Core::V1::SecurityContext,NilClass]
    attribute :securityContext, K8s::Model::Api::Core::V1::SecurityContext.optional.default(nil)

    # Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :stdin, K8s::API::Types::Bool.optional.default(nil)

    # Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :stdinOnce, K8s::API::Types::Bool.optional.default(nil)

    # Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.
    # @return [K8s::API::Types::String,NilClass]
    attribute :terminationMessagePath, K8s::API::Types::String.optional.default(nil)

    # Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.
    # @return [K8s::API::Types::String,NilClass]
    attribute :terminationMessagePolicy, K8s::API::Types::String.optional.default(nil)

    # Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :tty, K8s::API::Types::Bool.optional.default(nil)

    # volumeDevices is the list of block devices to be used by the container. This is a beta feature.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeDevice),NilClass]
    attribute :volumeDevices, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeDevice).optional.default(nil)

    # Pod volumes to mount into the container's filesystem. Cannot be updated.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeMount),NilClass]
    attribute :volumeMounts, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeMount).optional.default(nil)

    # Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.
    # @return [K8s::API::Types::String,NilClass]
    attribute :workingDir, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
