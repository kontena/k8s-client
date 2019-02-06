# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/admissionregistration/v1alpha1"
require 'k8s/model/api/admissionregistration/v1alpha1/initializer'
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'

module K8s::Model::Api::Admissionregistration::V1alpha1
  class InitializerConfiguration < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Initializers is a list of resources and their default initializers Order-sensitive. When merging multiple InitializerConfigurations, we sort the initializers from different InitializerConfigurations by the name of the InitializerConfigurations; the order of the initializers from the same InitializerConfiguration is preserved.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Admissionregistration::V1alpha1::Initializer),NilClass]
    attribute :initializers, K8s::API::Types::Array.of(K8s::Model::Api::Admissionregistration::V1alpha1::Initializer).optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    register_paths [
      '/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations/{name}'
    ]
  end
end
