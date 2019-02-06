# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class GlusterfsPersistentVolumeSource < K8s::TypedResource
    # EndpointsName is the endpoint name that details Glusterfs topology. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
    # @return [K8s::API::Types::String]
    attribute :endpoints, K8s::API::Types::String

    # EndpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
    # @return [K8s::API::Types::String,NilClass]
    attribute :endpointsNamespace, K8s::API::Types::String.optional.default(nil)

    # Path is the Glusterfs volume path. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
    # @return [K8s::API::Types::String]
    attribute :path, K8s::API::Types::String

    # ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://releases.k8s.io/HEAD/examples/volumes/glusterfs/README.md#create-a-pod
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    register_paths [
      
    ]
  end
end
