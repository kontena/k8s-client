# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/allowed_flex_volume'
require 'k8s/model/api/extensions/v1beta1/allowed_host_path'
require 'k8s/model/api/extensions/v1beta1/fs_group_strategy_options'
require 'k8s/model/api/extensions/v1beta1/host_port_range'
require 'k8s/model/api/extensions/v1beta1/run_as_group_strategy_options'
require 'k8s/model/api/extensions/v1beta1/run_as_user_strategy_options'
require 'k8s/model/api/extensions/v1beta1/se_linux_strategy_options'
require 'k8s/model/api/extensions/v1beta1/supplemental_groups_strategy_options'

module K8s::Model::Api::Extensions::V1beta1
  class PodSecurityPolicySpec < K8s::TypedResource
    # allowPrivilegeEscalation determines if a pod can request to allow privilege escalation. If unspecified, defaults to true.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :allowPrivilegeEscalation, K8s::API::Types::Bool.optional.default(nil)

    # allowedCapabilities is a list of capabilities that can be requested to add to the container. Capabilities in this field may be added at the pod author's discretion. You must not list a capability in both allowedCapabilities and requiredDropCapabilities.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :allowedCapabilities, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # allowedFlexVolumes is a whitelist of allowed Flexvolumes.  Empty or nil indicates that all Flexvolumes may be used.  This parameter is effective only when the usage of the Flexvolumes is allowed in the "volumes" field.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::AllowedFlexVolume),NilClass]
    attribute :allowedFlexVolumes, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::AllowedFlexVolume).optional.default(nil)

    # allowedHostPaths is a white list of allowed host paths. Empty indicates that all host paths may be used.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::AllowedHostPath),NilClass]
    attribute :allowedHostPaths, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::AllowedHostPath).optional.default(nil)

    # AllowedProcMountTypes is a whitelist of allowed ProcMountTypes. Empty or nil indicates that only the DefaultProcMountType may be used. This requires the ProcMountType feature flag to be enabled.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :allowedProcMountTypes, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # allowedUnsafeSysctls is a list of explicitly allowed unsafe sysctls, defaults to none. Each entry is either a plain sysctl name or ends in "*" in which case it is considered as a prefix of allowed sysctls. Single * means all unsafe sysctls are allowed. Kubelet has to whitelist all allowed unsafe sysctls explicitly to avoid rejection.

    # Examples: e.g. "foo/*" allows "foo/bar", "foo/baz", etc. e.g. "foo.*" allows "foo.bar", "foo.baz", etc.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :allowedUnsafeSysctls, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # defaultAddCapabilities is the default set of capabilities that will be added to the container unless the pod spec specifically drops the capability.  You may not list a capability in both defaultAddCapabilities and requiredDropCapabilities. Capabilities added here are implicitly allowed, and need not be included in the allowedCapabilities list.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :defaultAddCapabilities, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # defaultAllowPrivilegeEscalation controls the default setting for whether a process can gain more privileges than its parent process.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :defaultAllowPrivilegeEscalation, K8s::API::Types::Bool.optional.default(nil)

    # forbiddenSysctls is a list of explicitly forbidden sysctls, defaults to none. Each entry is either a plain sysctl name or ends in "*" in which case it is considered as a prefix of forbidden sysctls. Single * means all sysctls are forbidden.

    # Examples: e.g. "foo/*" forbids "foo/bar", "foo/baz", etc. e.g. "foo.*" forbids "foo.bar", "foo.baz", etc.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :forbiddenSysctls, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # fsGroup is the strategy that will dictate what fs group is used by the SecurityContext.
    # @return [K8s::Model::Api::Extensions::V1beta1::FSGroupStrategyOptions]
    attribute :fsGroup, K8s::Model::Api::Extensions::V1beta1::FSGroupStrategyOptions

    # hostIPC determines if the policy allows the use of HostIPC in the pod spec.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :hostIPC, K8s::API::Types::Bool.optional.default(nil)

    # hostNetwork determines if the policy allows the use of HostNetwork in the pod spec.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :hostNetwork, K8s::API::Types::Bool.optional.default(nil)

    # hostPID determines if the policy allows the use of HostPID in the pod spec.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :hostPID, K8s::API::Types::Bool.optional.default(nil)

    # hostPorts determines which host port ranges are allowed to be exposed.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::HostPortRange),NilClass]
    attribute :hostPorts, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::HostPortRange).optional.default(nil)

    # privileged determines if a pod can request to be run as privileged.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :privileged, K8s::API::Types::Bool.optional.default(nil)

    # readOnlyRootFilesystem when set to true will force containers to run with a read only root file system.  If the container specifically requests to run with a non-read only root file system the PSP should deny the pod. If set to false the container may run with a read only root file system if it wishes but it will not be forced to.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnlyRootFilesystem, K8s::API::Types::Bool.optional.default(nil)

    # requiredDropCapabilities are the capabilities that will be dropped from the container.  These are required to be dropped and cannot be added.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :requiredDropCapabilities, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # RunAsGroup is the strategy that will dictate the allowable RunAsGroup values that may be set. If this field is omitted, the pod's RunAsGroup can take any value. This field requires the RunAsGroup feature gate to be enabled.
    # @return [K8s::Model::Api::Extensions::V1beta1::RunAsGroupStrategyOptions,NilClass]
    attribute :runAsGroup, K8s::Model::Api::Extensions::V1beta1::RunAsGroupStrategyOptions.optional.default(nil)

    # runAsUser is the strategy that will dictate the allowable RunAsUser values that may be set.
    # @return [K8s::Model::Api::Extensions::V1beta1::RunAsUserStrategyOptions]
    attribute :runAsUser, K8s::Model::Api::Extensions::V1beta1::RunAsUserStrategyOptions

    # seLinux is the strategy that will dictate the allowable labels that may be set.
    # @return [K8s::Model::Api::Extensions::V1beta1::SELinuxStrategyOptions]
    attribute :seLinux, K8s::Model::Api::Extensions::V1beta1::SELinuxStrategyOptions

    # supplementalGroups is the strategy that will dictate what supplemental groups are used by the SecurityContext.
    # @return [K8s::Model::Api::Extensions::V1beta1::SupplementalGroupsStrategyOptions]
    attribute :supplementalGroups, K8s::Model::Api::Extensions::V1beta1::SupplementalGroupsStrategyOptions

    # volumes is a white list of allowed volume plugins. Empty indicates that no volumes may be used. To allow all volumes you may use '*'.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :volumes, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths [
      
    ]
  end
end
