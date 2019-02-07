# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_definition_spec'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_definition_status'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceDefinition < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec describes how the user wants the resources to appear
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionSpec]
    attribute :spec, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionSpec

    # Status indicates the actual state of the CustomResourceDefinition
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionStatus,NilClass]
    attribute :status, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionStatus.optional.default(nil)

    register_paths ["/apis/apiextensions.k8s.io/v1beta1/customresourcedefinitions/{name}","/apis/apiextensions.k8s.io/v1beta1/customresourcedefinitions/{name}/status"]
  end
end
