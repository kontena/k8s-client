# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/capabilities'
require 'k8s/model/api/core/v1/se_linux_options'

module K8s::Model::Api::Core::V1
  class SecurityContext < K8s::TypedResource
    # AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :allowPrivilegeEscalation, K8s::API::Types::Bool.optional.default(nil)

    # The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime.
    # @return [K8s::Model::Api::Core::V1::Capabilities,NilClass]
    attribute :capabilities, K8s::Model::Api::Core::V1::Capabilities.optional.default(nil)

    # Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :privileged, K8s::API::Types::Bool.optional.default(nil)

    # procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled.
    # @return [K8s::API::Types::String,NilClass]
    attribute :procMount, K8s::API::Types::String.optional.default(nil)

    # Whether this container has a read-only root filesystem. Default is false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnlyRootFilesystem, K8s::API::Types::Bool.optional.default(nil)

    # The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :runAsGroup, K8s::API::Types::Integer.optional.default(nil)

    # Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :runAsNonRoot, K8s::API::Types::Bool.optional.default(nil)

    # The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :runAsUser, K8s::API::Types::Integer.optional.default(nil)

    # The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    # @return [K8s::Model::Api::Core::V1::SELinuxOptions,NilClass]
    attribute :seLinuxOptions, K8s::Model::Api::Core::V1::SELinuxOptions.optional.default(nil)

    register_paths [
      
    ]
  end
end
