# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/admissionregistration/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/admissionregistration/v1beta1/webhook'

module K8s::Model::Api::Admissionregistration::V1beta1
  class ValidatingWebhookConfiguration < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Webhooks is a list of webhooks and the affected resources and operations.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Admissionregistration::V1beta1::Webhook),NilClass]
    attribute :webhooks, K8s::API::Types::Array.of(K8s::Model::Api::Admissionregistration::V1beta1::Webhook).optional.default(nil)

    register_paths [
      '/apis/admissionregistration.k8s.io/v1beta1/validatingwebhookconfigurations/{name}'
    ]
  end
end
