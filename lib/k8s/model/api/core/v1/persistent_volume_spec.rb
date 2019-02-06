# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/aws_elastic_block_store_volume_source'
require 'k8s/model/api/core/v1/azure_disk_volume_source'
require 'k8s/model/api/core/v1/azure_file_persistent_volume_source'
require 'k8s/model/api/core/v1/ceph_fs_persistent_volume_source'
require 'k8s/model/api/core/v1/cinder_persistent_volume_source'
require 'k8s/model/api/core/v1/object_reference'
require 'k8s/model/api/core/v1/csi_persistent_volume_source'
require 'k8s/model/api/core/v1/fc_volume_source'
require 'k8s/model/api/core/v1/flex_persistent_volume_source'
require 'k8s/model/api/core/v1/flocker_volume_source'
require 'k8s/model/api/core/v1/gce_persistent_disk_volume_source'
require 'k8s/model/api/core/v1/glusterfs_persistent_volume_source'
require 'k8s/model/api/core/v1/host_path_volume_source'
require 'k8s/model/api/core/v1/iscsi_persistent_volume_source'
require 'k8s/model/api/core/v1/local_volume_source'
require 'k8s/model/api/core/v1/nfs_volume_source'
require 'k8s/model/api/core/v1/volume_node_affinity'
require 'k8s/model/api/core/v1/photon_persistent_disk_volume_source'
require 'k8s/model/api/core/v1/portworx_volume_source'
require 'k8s/model/api/core/v1/quobyte_volume_source'
require 'k8s/model/api/core/v1/rbd_persistent_volume_source'
require 'k8s/model/api/core/v1/scale_io_persistent_volume_source'
require 'k8s/model/api/core/v1/storage_os_persistent_volume_source'
require 'k8s/model/api/core/v1/vsphere_virtual_disk_volume_source'

module K8s::Model::Api::Core::V1
  class PersistentVolumeSpec < K8s::TypedResource
    # AccessModes contains all ways the volume can be mounted. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :accessModes, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    # @return [K8s::Model::Api::Core::V1::AWSElasticBlockStoreVolumeSource,NilClass]
    attribute :awsElasticBlockStore, K8s::Model::Api::Core::V1::AWSElasticBlockStoreVolumeSource.optional.default(nil)

    # AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
    # @return [K8s::Model::Api::Core::V1::AzureDiskVolumeSource,NilClass]
    attribute :azureDisk, K8s::Model::Api::Core::V1::AzureDiskVolumeSource.optional.default(nil)

    # AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
    # @return [K8s::Model::Api::Core::V1::AzureFilePersistentVolumeSource,NilClass]
    attribute :azureFile, K8s::Model::Api::Core::V1::AzureFilePersistentVolumeSource.optional.default(nil)

    # A description of the persistent volume's resources and capacity. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :capacity, K8s::API::Types::Hash.optional.default(nil)

    # CephFS represents a Ceph FS mount on the host that shares a pod's lifetime
    # @return [K8s::Model::Api::Core::V1::CephFSPersistentVolumeSource,NilClass]
    attribute :cephfs, K8s::Model::Api::Core::V1::CephFSPersistentVolumeSource.optional.default(nil)

    # Cinder represents a cinder volume attached and mounted on kubelets host machine More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
    # @return [K8s::Model::Api::Core::V1::CinderPersistentVolumeSource,NilClass]
    attribute :cinder, K8s::Model::Api::Core::V1::CinderPersistentVolumeSource.optional.default(nil)

    # ClaimRef is part of a bi-directional binding between PersistentVolume and PersistentVolumeClaim. Expected to be non-nil when bound. claim.VolumeName is the authoritative bind between PV and PVC. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#binding
    # @return [K8s::Model::Api::Core::V1::ObjectReference,NilClass]
    attribute :claimRef, K8s::Model::Api::Core::V1::ObjectReference.optional.default(nil)

    # CSI represents storage that handled by an external CSI driver (Beta feature).
    # @return [K8s::Model::Api::Core::V1::CSIPersistentVolumeSource,NilClass]
    attribute :csi, K8s::Model::Api::Core::V1::CSIPersistentVolumeSource.optional.default(nil)

    # FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
    # @return [K8s::Model::Api::Core::V1::FCVolumeSource,NilClass]
    attribute :fc, K8s::Model::Api::Core::V1::FCVolumeSource.optional.default(nil)

    # FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
    # @return [K8s::Model::Api::Core::V1::FlexPersistentVolumeSource,NilClass]
    attribute :flexVolume, K8s::Model::Api::Core::V1::FlexPersistentVolumeSource.optional.default(nil)

    # Flocker represents a Flocker volume attached to a kubelet's host machine and exposed to the pod for its usage. This depends on the Flocker control service being running
    # @return [K8s::Model::Api::Core::V1::FlockerVolumeSource,NilClass]
    attribute :flocker, K8s::Model::Api::Core::V1::FlockerVolumeSource.optional.default(nil)

    # GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    # @return [K8s::Model::Api::Core::V1::GCEPersistentDiskVolumeSource,NilClass]
    attribute :gcePersistentDisk, K8s::Model::Api::Core::V1::GCEPersistentDiskVolumeSource.optional.default(nil)

    # Glusterfs represents a Glusterfs volume that is attached to a host and exposed to the pod. Provisioned by an admin. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md
    # @return [K8s::Model::Api::Core::V1::GlusterfsPersistentVolumeSource,NilClass]
    attribute :glusterfs, K8s::Model::Api::Core::V1::GlusterfsPersistentVolumeSource.optional.default(nil)

    # HostPath represents a directory on the host. Provisioned by a developer or tester. This is useful for single-node development and testing only! On-host storage is not supported in any way and WILL NOT WORK in a multi-node cluster. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    # @return [K8s::Model::Api::Core::V1::HostPathVolumeSource,NilClass]
    attribute :hostPath, K8s::Model::Api::Core::V1::HostPathVolumeSource.optional.default(nil)

    # ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. Provisioned by an admin.
    # @return [K8s::Model::Api::Core::V1::ISCSIPersistentVolumeSource,NilClass]
    attribute :iscsi, K8s::Model::Api::Core::V1::ISCSIPersistentVolumeSource.optional.default(nil)

    # Local represents directly-attached storage with node affinity
    # @return [K8s::Model::Api::Core::V1::LocalVolumeSource,NilClass]
    attribute :local, K8s::Model::Api::Core::V1::LocalVolumeSource.optional.default(nil)

    # A list of mount options, e.g. ["ro", "soft"]. Not validated - mount will simply fail if one is invalid. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :mountOptions, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # NFS represents an NFS mount on the host. Provisioned by an admin. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    # @return [K8s::Model::Api::Core::V1::NFSVolumeSource,NilClass]
    attribute :nfs, K8s::Model::Api::Core::V1::NFSVolumeSource.optional.default(nil)

    # NodeAffinity defines constraints that limit what nodes this volume can be accessed from. This field influences the scheduling of pods that use this volume.
    # @return [K8s::Model::Api::Core::V1::VolumeNodeAffinity,NilClass]
    attribute :nodeAffinity, K8s::Model::Api::Core::V1::VolumeNodeAffinity.optional.default(nil)

    # What happens to a persistent volume when released from its claim. Valid options are Retain (default for manually created PersistentVolumes), Delete (default for dynamically provisioned PersistentVolumes), and Recycle (deprecated). Recycle must be supported by the volume plugin underlying this PersistentVolume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#reclaiming
    # @return [K8s::API::Types::String,NilClass]
    attribute :persistentVolumeReclaimPolicy, K8s::API::Types::String.optional.default(nil)

    # PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine
    # @return [K8s::Model::Api::Core::V1::PhotonPersistentDiskVolumeSource,NilClass]
    attribute :photonPersistentDisk, K8s::Model::Api::Core::V1::PhotonPersistentDiskVolumeSource.optional.default(nil)

    # PortworxVolume represents a portworx volume attached and mounted on kubelets host machine
    # @return [K8s::Model::Api::Core::V1::PortworxVolumeSource,NilClass]
    attribute :portworxVolume, K8s::Model::Api::Core::V1::PortworxVolumeSource.optional.default(nil)

    # Quobyte represents a Quobyte mount on the host that shares a pod's lifetime
    # @return [K8s::Model::Api::Core::V1::QuobyteVolumeSource,NilClass]
    attribute :quobyte, K8s::Model::Api::Core::V1::QuobyteVolumeSource.optional.default(nil)

    # RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md
    # @return [K8s::Model::Api::Core::V1::RBDPersistentVolumeSource,NilClass]
    attribute :rbd, K8s::Model::Api::Core::V1::RBDPersistentVolumeSource.optional.default(nil)

    # ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
    # @return [K8s::Model::Api::Core::V1::ScaleIOPersistentVolumeSource,NilClass]
    attribute :scaleIO, K8s::Model::Api::Core::V1::ScaleIOPersistentVolumeSource.optional.default(nil)

    # Name of StorageClass to which this persistent volume belongs. Empty value means that this volume does not belong to any StorageClass.
    # @return [K8s::API::Types::String,NilClass]
    attribute :storageClassName, K8s::API::Types::String.optional.default(nil)

    # StorageOS represents a StorageOS volume that is attached to the kubelet's host machine and mounted into the pod More info: https://releases.k8s.io/HEAD/examples/volumes/storageos/README.md
    # @return [K8s::Model::Api::Core::V1::StorageOSPersistentVolumeSource,NilClass]
    attribute :storageos, K8s::Model::Api::Core::V1::StorageOSPersistentVolumeSource.optional.default(nil)

    # volumeMode defines if a volume is intended to be used with a formatted filesystem or to remain in raw block state. Value of Filesystem is implied when not included in spec. This is a beta feature.
    # @return [K8s::API::Types::String,NilClass]
    attribute :volumeMode, K8s::API::Types::String.optional.default(nil)

    # VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine
    # @return [K8s::Model::Api::Core::V1::VsphereVirtualDiskVolumeSource,NilClass]
    attribute :vsphereVolume, K8s::Model::Api::Core::V1::VsphereVirtualDiskVolumeSource.optional.default(nil)

    register_paths [
      
    ]
  end
end
