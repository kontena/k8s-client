# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"


module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceColumnDefinition < K8s::TypedResource
    # JSONPath is a simple JSON path, i.e. with array notation.
    # @return [K8s::API::Types::String]
    attribute :JSONPath, K8s::API::Types::String

    # description is a human readable description of this column.
    # @return [K8s::API::Types::String,NilClass]
    attribute :description, K8s::API::Types::String.optional.default(nil)

    # format is an optional OpenAPI type definition for this column. The 'name' format is applied to the primary identifier column to assist in clients identifying column is the resource name. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for more.
    # @return [K8s::API::Types::String,NilClass]
    attribute :format, K8s::API::Types::String.optional.default(nil)

    # name is a human readable name for the column.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # priority is an integer defining the relative importance of this column compared to others. Lower numbers are considered higher priority. Columns that may be omitted in limited space scenarios should be given a higher priority.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :priority, K8s::API::Types::Integer.optional.default(nil)

    # type is an OpenAPI type definition for this column. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for more.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
