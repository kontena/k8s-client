# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/core/v1/resource_quota_spec'
require 'k8s/model/api/core/v1/resource_quota_status'

module K8s::Model::Api::Core::V1
  class ResourceQuota < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec defines the desired quota. https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::Model::Api::Core::V1::ResourceQuotaSpec,NilClass]
    attribute :spec, K8s::Model::Api::Core::V1::ResourceQuotaSpec.optional.default(nil)

    # Status defines the actual enforced quota and its current usage. https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::Model::Api::Core::V1::ResourceQuotaStatus,NilClass]
    attribute :status, K8s::Model::Api::Core::V1::ResourceQuotaStatus.optional.default(nil)

    register_paths [
      '/api/v1/namespaces/{namespace}/resourcequotas/{name}',
      '/api/v1/namespaces/{namespace}/resourcequotas/{name}/status'
    ]
  end
end
