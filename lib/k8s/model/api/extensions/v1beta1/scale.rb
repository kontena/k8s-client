# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/extensions/v1beta1/scale_spec'
require 'k8s/model/api/extensions/v1beta1/scale_status'

module K8s::Model::Api::Extensions::V1beta1
  class Scale < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # defines the behavior of the scale. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status.
    # @return [K8s::Model::Api::Extensions::V1beta1::ScaleSpec,NilClass]
    attribute :spec, K8s::Model::Api::Extensions::V1beta1::ScaleSpec.optional.default(nil)

    # current status of the scale. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status. Read-only.
    # @return [K8s::Model::Api::Extensions::V1beta1::ScaleStatus,NilClass]
    attribute :status, K8s::Model::Api::Extensions::V1beta1::ScaleStatus.optional.default(nil)

    register_paths [
      '/apis/extensions/v1beta1/namespaces/{namespace}/deployments/{name}/scale',
      '/apis/extensions/v1beta1/namespaces/{namespace}/replicasets/{name}/scale',
      '/apis/extensions/v1beta1/namespaces/{namespace}/replicationcontrollers/{name}/scale'
    ]
  end
end
