# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/apps/v1beta2/stateful_set_spec'
require 'k8s/model/api/apps/v1beta2/stateful_set_status'

module K8s::Model::Api::Apps::V1beta2
  class StatefulSet < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec defines the desired identities of pods in this set.
    # @return [K8s::Model::Api::Apps::V1beta2::StatefulSetSpec,NilClass]
    attribute :spec, K8s::Model::Api::Apps::V1beta2::StatefulSetSpec.optional.default(nil)

    # Status is the current status of Pods in this StatefulSet. This data may be out of date by some window of time.
    # @return [K8s::Model::Api::Apps::V1beta2::StatefulSetStatus,NilClass]
    attribute :status, K8s::Model::Api::Apps::V1beta2::StatefulSetStatus.optional.default(nil)

    register_paths ["/apis/apps/v1beta2/namespaces/{namespace}/statefulsets/{name}","/apis/apps/v1beta2/namespaces/{namespace}/statefulsets/{name}/status"]
  end
end
