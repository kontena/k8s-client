# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_column_definition'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_conversion'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_definition_names'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_subresources'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_validation'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_definition_version'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceDefinitionSpec < K8s::TypedResource
    # AdditionalPrinterColumns are additional columns shown e.g. in kubectl next to the name. Defaults to a created-at column. Optional, the global columns for all versions. Top-level and per-version columns are mutually exclusive.
    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceColumnDefinition),NilClass]
    attribute :additionalPrinterColumns, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceColumnDefinition).optional.default(nil)

    # `conversion` defines conversion settings for the CRD.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceConversion,NilClass]
    attribute :conversion, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceConversion.optional.default(nil)

    # Group is the group this resource belongs in
    # @return [K8s::API::Types::String]
    attribute :group, K8s::API::Types::String

    # Names are the names used to describe this custom resource
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionNames]
    attribute :names, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionNames

    # Scope indicates whether this resource is cluster or namespace scoped.  Default is namespaced
    # @return [K8s::API::Types::String]
    attribute :scope, K8s::API::Types::String

    # Subresources describes the subresources for CustomResource Optional, the global subresources for all versions. Top-level and per-version subresources are mutually exclusive.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresources,NilClass]
    attribute :subresources, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresources.optional.default(nil)

    # Validation describes the validation methods for CustomResources Optional, the global validation schema for all versions. Top-level and per-version schemas are mutually exclusive.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceValidation,NilClass]
    attribute :validation, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceValidation.optional.default(nil)

    # Version is the version this resource belongs in Should be always first item in Versions field if provided. Optional, but at least one of Version or Versions must be set. Deprecated: Please use `Versions`.
    # @return [K8s::API::Types::String,NilClass]
    attribute :version, K8s::API::Types::String.optional.default(nil)

    # Versions is the list of all supported versions for this resource. If Version field is provided, this field is optional. Validation: All versions must use the same validation schema for now. i.e., top level Validation field is applied to all of these versions. Order: The version name will be used to compute the order. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionVersion),NilClass]
    attribute :versions, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionVersion).optional.default(nil)

    register_paths [
      
    ]
  end
end
