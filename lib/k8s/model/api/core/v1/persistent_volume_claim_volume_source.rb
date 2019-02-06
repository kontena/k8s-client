# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class PersistentVolumeClaimVolumeSource < K8s::TypedResource
    # ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
    # @return [K8s::API::Types::String]
    attribute :claimName, K8s::API::Types::String

    # Will force the ReadOnly setting in VolumeMounts. Default false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    register_paths [
      
    ]
  end
end
