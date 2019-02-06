# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/json_schema_props_or_bool'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/json_schema_props'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/json'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/external_documentation'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/json_schema_props_or_array'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class JSONSchemaProps < K8s::TypedResource
    # @return [K8s::API::Types::String,NilClass]
    attribute :_ref, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :_schema, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaPropsOrBool,NilClass]
    attribute :additionalItems, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaPropsOrBool.optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaPropsOrBool,NilClass]
    attribute :additionalProperties, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaPropsOrBool.optional.default(nil)

    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps),NilClass]
    attribute :allOf, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps).optional.default(nil)

    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps),NilClass]
    attribute :anyOf, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps).optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSON,NilClass]
    attribute :default, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSON.optional.default(nil)

    # @return [K8s::API::Types::Hash,NilClass]
    attribute :definitions, K8s::API::Types::Hash.optional.default(nil)

    # @return [K8s::API::Types::Hash,NilClass]
    attribute :dependencies, K8s::API::Types::Hash.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :description, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSON),NilClass]
    attribute :enum, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSON).optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSON,NilClass]
    attribute :example, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSON.optional.default(nil)

    # @return [K8s::API::Types::Bool,NilClass]
    attribute :exclusiveMaximum, K8s::API::Types::Bool.optional.default(nil)

    # @return [K8s::API::Types::Bool,NilClass]
    attribute :exclusiveMinimum, K8s::API::Types::Bool.optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::ExternalDocumentation,NilClass]
    attribute :externalDocs, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::ExternalDocumentation.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :format, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :id, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaPropsOrArray,NilClass]
    attribute :items, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaPropsOrArray.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :maxItems, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :maxLength, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :maxProperties, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :maximum, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minItems, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minLength, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minProperties, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minimum, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::API::Types::Integer,NilClass]
    attribute :multipleOf, K8s::API::Types::Integer.optional.default(nil)

    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps,NilClass]
    attribute :not, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps.optional.default(nil)

    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps),NilClass]
    attribute :oneOf, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps).optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :pattern, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::Hash,NilClass]
    attribute :patternProperties, K8s::API::Types::Hash.optional.default(nil)

    # @return [K8s::API::Types::Hash,NilClass]
    attribute :properties, K8s::API::Types::Hash.optional.default(nil)

    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :required, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :title, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::Bool,NilClass]
    attribute :uniqueItems, K8s::API::Types::Bool.optional.default(nil)

    register_paths [
      
    ]
  end
end
