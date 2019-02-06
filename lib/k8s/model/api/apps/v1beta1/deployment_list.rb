# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta1"
require 'k8s/model/api/apps/v1beta1/deployment'
require 'k8s/model/apimachinery/apis/meta/v1/list_meta'

module K8s::Model::Api::Apps::V1beta1
  class DeploymentList < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Items is the list of Deployments.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta1::Deployment)]
    attribute :items, K8s::API::Types::Array.of(K8s::Model::Api::Apps::V1beta1::Deployment)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard list metadata.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ListMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ListMeta.optional.default(nil)

    register_paths [
      '/apis/apps/v1beta1/deployments',
      '/apis/apps/v1beta1/namespaces/{namespace}/deployments'
    ]
  end
end
