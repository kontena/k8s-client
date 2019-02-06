# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/json_schema_props'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceValidation < K8s::TypedResource
    # OpenAPIV3Schema is the OpenAPI v3 schema to be validated against.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps,NilClass]
    attribute :openAPIV3Schema, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::JSONSchemaProps.optional.default(nil)

    register_paths [
      
    ]
  end
end
