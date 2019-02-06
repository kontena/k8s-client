# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/local_object_reference'

module K8s::Model::Api::Core::V1
  class ISCSIVolumeSource < K8s::TypedResource
    # whether support iSCSI Discovery CHAP authentication
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :chapAuthDiscovery, K8s::API::Types::Bool.optional.default(nil)

    # whether support iSCSI Session CHAP authentication
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :chapAuthSession, K8s::API::Types::Bool.optional.default(nil)

    # Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi
    # @return [K8s::API::Types::String,NilClass]
    attribute :fsType, K8s::API::Types::String.optional.default(nil)

    # Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection.
    # @return [K8s::API::Types::String,NilClass]
    attribute :initiatorName, K8s::API::Types::String.optional.default(nil)

    # Target iSCSI Qualified Name.
    # @return [K8s::API::Types::String]
    attribute :iqn, K8s::API::Types::String

    # iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp).
    # @return [K8s::API::Types::String,NilClass]
    attribute :iscsiInterface, K8s::API::Types::String.optional.default(nil)

    # iSCSI Target Lun number.
    # @return [K8s::API::Types::Integer]
    attribute :lun, K8s::API::Types::Integer

    # iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :portals, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # CHAP Secret for iSCSI target and initiator authentication
    # @return [K8s::Model::Api::Core::V1::LocalObjectReference,NilClass]
    attribute :secretRef, K8s::Model::Api::Core::V1::LocalObjectReference.optional.default(nil)

    # iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260).
    # @return [K8s::API::Types::String]
    attribute :targetPortal, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
