# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_column_definition'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_validation'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_subresources'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceDefinitionVersion < K8s::TypedResource
    # AdditionalPrinterColumns are additional columns shown e.g. in kubectl next to the name. Defaults to a created-at column. Top-level and per-version columns are mutually exclusive. Per-version columns must not all be set to identical values (top-level columns should be used instead) This field is alpha-level and is only honored by servers that enable the CustomResourceWebhookConversion feature. NOTE: CRDs created prior to 1.13 populated the top-level additionalPrinterColumns field by default. To apply an update that changes to per-version additionalPrinterColumns, the top-level additionalPrinterColumns field must be explicitly set to null
    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceColumnDefinition),NilClass]
    attribute :additionalPrinterColumns, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceColumnDefinition).optional.default(nil)

    # Name is the version name, e.g. “v1”, “v2beta1”, etc.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Schema describes the schema for CustomResource used in validation, pruning, and defaulting. Top-level and per-version schemas are mutually exclusive. Per-version schemas must not all be set to identical values (top-level validation schema should be used instead) This field is alpha-level and is only honored by servers that enable the CustomResourceWebhookConversion feature.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceValidation,NilClass]
    attribute :schema, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceValidation.optional.default(nil)

    # Served is a flag enabling/disabling this version from being served via REST APIs
    # @return [K8s::API::Types::Bool]
    attribute :served, K8s::API::Types::Bool

    # Storage flags the version as storage version. There must be exactly one flagged as storage version.
    # @return [K8s::API::Types::Bool]
    attribute :storage, K8s::API::Types::Bool

    # Subresources describes the subresources for CustomResource Top-level and per-version subresources are mutually exclusive. Per-version subresources must not all be set to identical values (top-level subresources should be used instead) This field is alpha-level and is only honored by servers that enable the CustomResourceWebhookConversion feature.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresources,NilClass]
    attribute :subresources, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresources.optional.default(nil)

    register_paths []
  end
end
