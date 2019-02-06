# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/status_details'
require 'k8s/model/apimachinery/apis/meta/v1/list_meta'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class Status < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Suggested HTTP return code for this status, 0 if not set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :code, K8s::API::Types::Integer.optional.default(nil)

    # Extended data associated with the reason.  Each reason may define its own extended details. This field is optional and the data returned is not guaranteed to conform to any schema except that defined by the reason type.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::StatusDetails,NilClass]
    attribute :details, K8s::Model::Apimachinery::Apis::Meta::V1::StatusDetails.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # A human-readable description of the status of this operation.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # Standard list metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ListMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ListMeta.optional.default(nil)

    # A machine-readable description of why this operation is in the "Failure" status. If this value is empty there is no information available. A Reason clarifies an HTTP status code but does not override it.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # Status of the operation. One of: "Success" or "Failure". More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#spec-and-status
    # @return [K8s::API::Types::String,NilClass]
    attribute :status, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
