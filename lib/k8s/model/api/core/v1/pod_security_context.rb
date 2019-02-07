# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/se_linux_options'
require 'k8s/model/api/core/v1/sysctl'

module K8s::Model::Api::Core::V1
  class PodSecurityContext < K8s::TypedResource
    # A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:

    # 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----

    # If unset, the Kubelet will not modify the ownership and permissions of any volume.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :fsGroup, K8s::API::Types::Integer.optional.default(nil)

    # The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :runAsGroup, K8s::API::Types::Integer.optional.default(nil)

    # Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :runAsNonRoot, K8s::API::Types::Bool.optional.default(nil)

    # The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :runAsUser, K8s::API::Types::Integer.optional.default(nil)

    # The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container.
    # @return [K8s::Model::Api::Core::V1::SELinuxOptions,NilClass]
    attribute :seLinuxOptions, K8s::Model::Api::Core::V1::SELinuxOptions.optional.default(nil)

    # A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::Integer),NilClass]
    attribute :supplementalGroups, K8s::API::Types::Array.of(K8s::API::Types::Integer).optional.default(nil)

    # Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Sysctl),NilClass]
    attribute :sysctls, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Sysctl).optional.default(nil)

    register_paths []
  end
end
