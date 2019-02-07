# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class NFSVolumeSource < K8s::TypedResource
    # Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    # @return [K8s::API::Types::String]
    attribute :path, K8s::API::Types::String

    # ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs
    # @return [K8s::API::Types::String]
    attribute :server, K8s::API::Types::String

    register_paths []
  end
end
