# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/preconditions'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class DeleteOptions < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # When present, indicates that modifications should not be persisted. An invalid or unrecognized dryRun directive will result in an error response and no further processing of the request. Valid values are: - All: all dry run stages will be processed
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :dryRun, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :gracePeriodSeconds, K8s::API::Types::Integer.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the "orphan" finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :orphanDependents, K8s::API::Types::Bool.optional.default(nil)

    # Must be fulfilled before a deletion is carried out. If not possible, a 409 Conflict status will be returned.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Preconditions,NilClass]
    attribute :preconditions, K8s::Model::Apimachinery::Apis::Meta::V1::Preconditions.optional.default(nil)

    # Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground.
    # @return [K8s::API::Types::String,NilClass]
    attribute :propagationPolicy, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
