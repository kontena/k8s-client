# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/aws_elastic_block_store_volume_source'
require 'k8s/model/api/core/v1/azure_disk_volume_source'
require 'k8s/model/api/core/v1/azure_file_volume_source'
require 'k8s/model/api/core/v1/ceph_fs_volume_source'
require 'k8s/model/api/core/v1/cinder_volume_source'
require 'k8s/model/api/core/v1/config_map_volume_source'
require 'k8s/model/api/core/v1/downward_api_volume_source'
require 'k8s/model/api/core/v1/empty_dir_volume_source'
require 'k8s/model/api/core/v1/fc_volume_source'
require 'k8s/model/api/core/v1/flex_volume_source'
require 'k8s/model/api/core/v1/flocker_volume_source'
require 'k8s/model/api/core/v1/gce_persistent_disk_volume_source'
require 'k8s/model/api/core/v1/git_repo_volume_source'
require 'k8s/model/api/core/v1/glusterfs_volume_source'
require 'k8s/model/api/core/v1/host_path_volume_source'
require 'k8s/model/api/core/v1/iscsi_volume_source'
require 'k8s/model/api/core/v1/nfs_volume_source'
require 'k8s/model/api/core/v1/persistent_volume_claim_volume_source'
require 'k8s/model/api/core/v1/photon_persistent_disk_volume_source'
require 'k8s/model/api/core/v1/portworx_volume_source'
require 'k8s/model/api/core/v1/projected_volume_source'
require 'k8s/model/api/core/v1/quobyte_volume_source'
require 'k8s/model/api/core/v1/rbd_volume_source'
require 'k8s/model/api/core/v1/scale_io_volume_source'
require 'k8s/model/api/core/v1/secret_volume_source'
require 'k8s/model/api/core/v1/storage_os_volume_source'
require 'k8s/model/api/core/v1/vsphere_virtual_disk_volume_source'

module K8s::Model::Api::Core::V1
  class Volume < K8s::TypedResource
    # AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
    # @return [K8s::Model::Api::Core::V1::AWSElasticBlockStoreVolumeSource,NilClass]
    attribute :awsElasticBlockStore, K8s::Model::Api::Core::V1::AWSElasticBlockStoreVolumeSource.optional.default(nil)

    # AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
    # @return [K8s::Model::Api::Core::V1::AzureDiskVolumeSource,NilClass]
    attribute :azureDisk, K8s::Model::Api::Core::V1::AzureDiskVolumeSource.optional.default(nil)

    # AzureFile represents an Azure File Service mount on the host and bind mount to the pod.
    # @return [K8s::Model::Api::Core::V1::AzureFileVolumeSource,NilClass]
    attribute :azureFile, K8s::Model::Api::Core::V1::AzureFileVolumeSource.optional.default(nil)

    # CephFS represents a Ceph FS mount on the host that shares a pod's lifetime
    # @return [K8s::Model::Api::Core::V1::CephFSVolumeSource,NilClass]
    attribute :cephfs, K8s::Model::Api::Core::V1::CephFSVolumeSource.optional.default(nil)

    # Cinder represents a cinder volume attached and mounted on kubelets host machine More info: https://releases.k8s.io/HEAD/examples/mysql-cinder-pd/README.md
    # @return [K8s::Model::Api::Core::V1::CinderVolumeSource,NilClass]
    attribute :cinder, K8s::Model::Api::Core::V1::CinderVolumeSource.optional.default(nil)

    # ConfigMap represents a configMap that should populate this volume
    # @return [K8s::Model::Api::Core::V1::ConfigMapVolumeSource,NilClass]
    attribute :configMap, K8s::Model::Api::Core::V1::ConfigMapVolumeSource.optional.default(nil)

    # DownwardAPI represents downward API about the pod that should populate this volume
    # @return [K8s::Model::Api::Core::V1::DownwardAPIVolumeSource,NilClass]
    attribute :downwardAPI, K8s::Model::Api::Core::V1::DownwardAPIVolumeSource.optional.default(nil)

    # EmptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
    # @return [K8s::Model::Api::Core::V1::EmptyDirVolumeSource,NilClass]
    attribute :emptyDir, K8s::Model::Api::Core::V1::EmptyDirVolumeSource.optional.default(nil)

    # FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.
    # @return [K8s::Model::Api::Core::V1::FCVolumeSource,NilClass]
    attribute :fc, K8s::Model::Api::Core::V1::FCVolumeSource.optional.default(nil)

    # FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
    # @return [K8s::Model::Api::Core::V1::FlexVolumeSource,NilClass]
    attribute :flexVolume, K8s::Model::Api::Core::V1::FlexVolumeSource.optional.default(nil)

    # Flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running
    # @return [K8s::Model::Api::Core::V1::FlockerVolumeSource,NilClass]
    attribute :flocker, K8s::Model::Api::Core::V1::FlockerVolumeSource.optional.default(nil)

    # GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
    # @return [K8s::Model::Api::Core::V1::GCEPersistentDiskVolumeSource,NilClass]
    attribute :gcePersistentDisk, K8s::Model::Api::Core::V1::GCEPersistentDiskVolumeSource.optional.default(nil)

    # GitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container.
    # @return [K8s::Model::Api::Core::V1::GitRepoVolumeSource,NilClass]
    attribute :gitRepo, K8s::Model::Api::Core::V1::GitRepoVolumeSource.optional.default(nil)

    # Glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md
    # @return [K8s::Model::Api::Core::V1::GlusterfsVolumeSource,NilClass]
    attribute :glusterfs, K8s::Model::Api::Core::V1::GlusterfsVolumeSource.optional.default(nil)

    # HostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath
    # @return [K8s::Model::Api::Core::V1::HostPathVolumeSource,NilClass]
    attribute :hostPath, K8s::Model::Api::Core::V1::HostPathVolumeSource.optional.default(nil)

    # ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://releases.k8s.io/HEAD/examples/volumes/iscsi/README.md
    # @return [K8s::Model::Api::Core::V1::ISCSIVolumeSource,NilClass]
    attribute :iscsi, K8s::Model::Api::Core::V1::ISCSIVolumeSource.optional.default(nil)

    # Volume's name. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # NFS represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    # @return [K8s::Model::Api::Core::V1::NFSVolumeSource,NilClass]
    attribute :nfs, K8s::Model::Api::Core::V1::NFSVolumeSource.optional.default(nil)

    # PersistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    # @return [K8s::Model::Api::Core::V1::PersistentVolumeClaimVolumeSource,NilClass]
    attribute :persistentVolumeClaim, K8s::Model::Api::Core::V1::PersistentVolumeClaimVolumeSource.optional.default(nil)

    # PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine
    # @return [K8s::Model::Api::Core::V1::PhotonPersistentDiskVolumeSource,NilClass]
    attribute :photonPersistentDisk, K8s::Model::Api::Core::V1::PhotonPersistentDiskVolumeSource.optional.default(nil)

    # PortworxVolume represents a portworx volume attached and mounted on kubelets host machine
    # @return [K8s::Model::Api::Core::V1::PortworxVolumeSource,NilClass]
    attribute :portworxVolume, K8s::Model::Api::Core::V1::PortworxVolumeSource.optional.default(nil)

    # Items for all in one resources secrets, configmaps, and downward API
    # @return [K8s::Model::Api::Core::V1::ProjectedVolumeSource,NilClass]
    attribute :projected, K8s::Model::Api::Core::V1::ProjectedVolumeSource.optional.default(nil)

    # Quobyte represents a Quobyte mount on the host that shares a pod's lifetime
    # @return [K8s::Model::Api::Core::V1::QuobyteVolumeSource,NilClass]
    attribute :quobyte, K8s::Model::Api::Core::V1::QuobyteVolumeSource.optional.default(nil)

    # RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://releases.k8s.io/HEAD/examples/volumes/rbd/README.md
    # @return [K8s::Model::Api::Core::V1::RBDVolumeSource,NilClass]
    attribute :rbd, K8s::Model::Api::Core::V1::RBDVolumeSource.optional.default(nil)

    # ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.
    # @return [K8s::Model::Api::Core::V1::ScaleIOVolumeSource,NilClass]
    attribute :scaleIO, K8s::Model::Api::Core::V1::ScaleIOVolumeSource.optional.default(nil)

    # Secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret
    # @return [K8s::Model::Api::Core::V1::SecretVolumeSource,NilClass]
    attribute :secret, K8s::Model::Api::Core::V1::SecretVolumeSource.optional.default(nil)

    # StorageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.
    # @return [K8s::Model::Api::Core::V1::StorageOSVolumeSource,NilClass]
    attribute :storageos, K8s::Model::Api::Core::V1::StorageOSVolumeSource.optional.default(nil)

    # VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine
    # @return [K8s::Model::Api::Core::V1::VsphereVirtualDiskVolumeSource,NilClass]
    attribute :vsphereVolume, K8s::Model::Api::Core::V1::VsphereVirtualDiskVolumeSource.optional.default(nil)

    register_paths []
  end
end
