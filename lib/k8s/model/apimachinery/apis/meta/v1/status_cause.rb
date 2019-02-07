# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class StatusCause < K8s::TypedResource
    # The field of the resource that has caused this error, as named by its JSON serialization. May include dot and postfix notation for nested attributes. Arrays are zero-indexed.  Fields may appear more than once in an array of causes due to fields having multiple errors. Optional.

    # Examples:

    #   "name" - the field "name" on the current resource

    #   "items[0].name" - the field "name" on the first array entry in "items"
    # @return [K8s::API::Types::String,NilClass]
    attribute :field, K8s::API::Types::String.optional.default(nil)

    # A human-readable description of the cause of the error.  This field may be presented as-is to a reader.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # A machine-readable description of the cause of the error. If this value is empty there is no information available.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
