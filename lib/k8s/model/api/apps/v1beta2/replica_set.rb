# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/apps/v1beta2/replica_set_spec'
require 'k8s/model/api/apps/v1beta2/replica_set_status'

module K8s::Model::Api::Apps::V1beta2
  class ReplicaSet < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # If the Labels of a ReplicaSet are empty, they are defaulted to be the same as the Pod(s) that the ReplicaSet manages. Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec defines the specification of the desired behavior of the ReplicaSet. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::Model::Api::Apps::V1beta2::ReplicaSetSpec,NilClass]
    attribute :spec, K8s::Model::Api::Apps::V1beta2::ReplicaSetSpec.optional.default(nil)

    # Status is the most recently observed status of the ReplicaSet. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::Model::Api::Apps::V1beta2::ReplicaSetStatus,NilClass]
    attribute :status, K8s::Model::Api::Apps::V1beta2::ReplicaSetStatus.optional.default(nil)

    register_paths [
      '/apis/apps/v1beta2/namespaces/{namespace}/replicasets/{name}',
      '/apis/apps/v1beta2/namespaces/{namespace}/replicasets/{name}/status'
    ]
  end
end
