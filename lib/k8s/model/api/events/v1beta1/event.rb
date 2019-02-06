# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/events/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/time'
require 'k8s/model/api/core/v1/event_source'
require 'k8s/model/apimachinery/apis/meta/v1/micro_time'
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/core/v1/object_reference'
require 'k8s/model/api/events/v1beta1/event_series'

module K8s::Model::Api::Events::V1beta1
  class Event < K8s::TypedResource
    # What action was taken/failed regarding to the regarding object.
    # @return [K8s::API::Types::String,NilClass]
    attribute :action, K8s::API::Types::String.optional.default(nil)

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Deprecated field assuring backward compatibility with core.v1 Event type
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :deprecatedCount, K8s::API::Types::Integer.optional.default(nil)

    # Deprecated field assuring backward compatibility with core.v1 Event type
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :deprecatedFirstTimestamp, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Deprecated field assuring backward compatibility with core.v1 Event type
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :deprecatedLastTimestamp, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Deprecated field assuring backward compatibility with core.v1 Event type
    # @return [K8s::Model::Api::Core::V1::EventSource,NilClass]
    attribute :deprecatedSource, K8s::Model::Api::Core::V1::EventSource.optional.default(nil)

    # Required. Time when this Event was first observed.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime]
    attribute :eventTime, K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Optional. A human-readable description of the status of this operation. Maximal length of the note is 1kB, but libraries should be prepared to handle values up to 64kB.
    # @return [K8s::API::Types::String,NilClass]
    attribute :note, K8s::API::Types::String.optional.default(nil)

    # Why the action was taken.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # The object this Event is about. In most cases it's an Object reporting controller implements. E.g. ReplicaSetController implements ReplicaSets and this event is emitted because it acts on some changes in a ReplicaSet object.
    # @return [K8s::Model::Api::Core::V1::ObjectReference,NilClass]
    attribute :regarding, K8s::Model::Api::Core::V1::ObjectReference.optional.default(nil)

    # Optional secondary object for more complex actions. E.g. when regarding object triggers a creation or deletion of related object.
    # @return [K8s::Model::Api::Core::V1::ObjectReference,NilClass]
    attribute :related, K8s::Model::Api::Core::V1::ObjectReference.optional.default(nil)

    # Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reportingController, K8s::API::Types::String.optional.default(nil)

    # ID of the controller instance, e.g. `kubelet-xyzf`.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reportingInstance, K8s::API::Types::String.optional.default(nil)

    # Data about the Event series this event represents or nil if it's a singleton Event.
    # @return [K8s::Model::Api::Events::V1beta1::EventSeries,NilClass]
    attribute :series, K8s::Model::Api::Events::V1beta1::EventSeries.optional.default(nil)

    # Type of this event (Normal, Warning), new types could be added in the future.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths [
      '/apis/events.k8s.io/v1beta1/namespaces/{namespace}/events/{name}'
    ]
  end
end
