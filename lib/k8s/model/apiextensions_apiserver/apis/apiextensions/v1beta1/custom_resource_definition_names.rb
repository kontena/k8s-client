# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"


module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceDefinitionNames < K8s::TypedResource
    # Categories is a list of grouped resources custom resources belong to (e.g. 'all')
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :categories, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Kind is the serialized kind of the resource.  It is normally CamelCase and singular.
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # ListKind is the serialized kind of the list for this resource.  Defaults to <kind>List.
    # @return [K8s::API::Types::String,NilClass]
    attribute :listKind, K8s::API::Types::String.optional.default(nil)

    # Plural is the plural name of the resource to serve.  It must match the name of the CustomResourceDefinition-registration too: plural.group and it must be all lowercase.
    # @return [K8s::API::Types::String]
    attribute :plural, K8s::API::Types::String

    # ShortNames are short names for the resource.  It must be all lowercase.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :shortNames, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Singular is the singular name of the resource.  It must be all lowercase  Defaults to lowercased <kind>
    # @return [K8s::API::Types::String,NilClass]
    attribute :singular, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
