# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/micro_time'
require 'k8s/model/apimachinery/apis/meta/v1/time'
require 'k8s/model/api/core/v1/object_reference'
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/core/v1/event_series'
require 'k8s/model/api/core/v1/event_source'

module K8s::Model::Api::Core::V1
  class Event < K8s::TypedResource
    # What action was taken/failed regarding to the Regarding object.
    # @return [K8s::API::Types::String,NilClass]
    attribute :action, K8s::API::Types::String.optional.default(nil)

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # The number of times this event has occurred.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :count, K8s::API::Types::Integer.optional.default(nil)

    # Time when this Event was first observed.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime,NilClass]
    attribute :eventTime, K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime.optional.default(nil)

    # The time at which the event was first recorded. (Time of server receipt is in TypeMeta.)
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :firstTimestamp, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # The object that this event is about.
    # @return [K8s::Model::Api::Core::V1::ObjectReference]
    attribute :involvedObject, K8s::Model::Api::Core::V1::ObjectReference

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # The time at which the most recent occurrence of this event was recorded.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastTimestamp, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # A human-readable description of the status of this operation.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta

    # This should be a short, machine understandable string that gives the reason for the transition into the object's current status.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # Optional secondary object for more complex actions.
    # @return [K8s::Model::Api::Core::V1::ObjectReference,NilClass]
    attribute :related, K8s::Model::Api::Core::V1::ObjectReference.optional.default(nil)

    # Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reportingComponent, K8s::API::Types::String.optional.default(nil)

    # ID of the controller instance, e.g. `kubelet-xyzf`.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reportingInstance, K8s::API::Types::String.optional.default(nil)

    # Data about the Event series this event represents or nil if it's a singleton Event.
    # @return [K8s::Model::Api::Core::V1::EventSeries,NilClass]
    attribute :series, K8s::Model::Api::Core::V1::EventSeries.optional.default(nil)

    # The component reporting this event. Should be a short machine understandable string.
    # @return [K8s::Model::Api::Core::V1::EventSource,NilClass]
    attribute :source, K8s::Model::Api::Core::V1::EventSource.optional.default(nil)

    # Type of this event (Normal, Warning), new types could be added in the future
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths ["/api/v1/namespaces/{namespace}/events/{name}"]
  end
end
