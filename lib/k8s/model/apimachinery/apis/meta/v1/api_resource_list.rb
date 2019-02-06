# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/api_resource'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class APIResourceList < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # groupVersion is the group and version this APIResourceList is for.
    # @return [K8s::API::Types::String]
    attribute :groupVersion, K8s::API::Types::String

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # resources contains the name of the resources and if they are namespaced.
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::APIResource)]
    attribute :resources, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::APIResource)

    register_paths [
      '/api/v1/',
      '/apis/admissionregistration.k8s.io/v1alpha1/',
      '/apis/admissionregistration.k8s.io/v1beta1/',
      '/apis/apiextensions.k8s.io/v1beta1/',
      '/apis/apiregistration.k8s.io/v1/',
      '/apis/apiregistration.k8s.io/v1beta1/',
      '/apis/apps/v1/',
      '/apis/apps/v1beta1/',
      '/apis/apps/v1beta2/',
      '/apis/auditregistration.k8s.io/v1alpha1/',
      '/apis/authentication.k8s.io/v1/',
      '/apis/authentication.k8s.io/v1beta1/',
      '/apis/authorization.k8s.io/v1/',
      '/apis/authorization.k8s.io/v1beta1/',
      '/apis/autoscaling/v1/',
      '/apis/autoscaling/v2beta1/',
      '/apis/autoscaling/v2beta2/',
      '/apis/batch/v1/',
      '/apis/batch/v1beta1/',
      '/apis/batch/v2alpha1/',
      '/apis/certificates.k8s.io/v1beta1/',
      '/apis/coordination.k8s.io/v1beta1/',
      '/apis/events.k8s.io/v1beta1/',
      '/apis/extensions/v1beta1/',
      '/apis/networking.k8s.io/v1/',
      '/apis/policy/v1beta1/',
      '/apis/rbac.authorization.k8s.io/v1/',
      '/apis/rbac.authorization.k8s.io/v1alpha1/',
      '/apis/rbac.authorization.k8s.io/v1beta1/',
      '/apis/scheduling.k8s.io/v1alpha1/',
      '/apis/scheduling.k8s.io/v1beta1/',
      '/apis/settings.k8s.io/v1alpha1/',
      '/apis/storage.k8s.io/v1/',
      '/apis/storage.k8s.io/v1alpha1/',
      '/apis/storage.k8s.io/v1beta1/'
    ]
  end
end
