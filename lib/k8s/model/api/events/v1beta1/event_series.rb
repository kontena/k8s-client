# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/events/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/micro_time'

module K8s::Model::Api::Events::V1beta1
  class EventSeries < K8s::TypedResource
    # Number of occurrences in this series up to the last heartbeat time
    # @return [K8s::API::Types::Integer]
    attribute :count, K8s::API::Types::Integer

    # Time when last Event from the series was seen before last heartbeat.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime]
    attribute :lastObservedTime, K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime

    # Information whether this series is ongoing or finished.
    # @return [K8s::API::Types::String]
    attribute :state, K8s::API::Types::String

    register_paths []
  end
end
