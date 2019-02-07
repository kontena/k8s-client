# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/micro_time'

module K8s::Model::Api::Core::V1
  class EventSeries < K8s::TypedResource
    # Number of occurrences in this series up to the last heartbeat time
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :count, K8s::API::Types::Integer.optional.default(nil)

    # Time of the last occurrence observed
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime,NilClass]
    attribute :lastObservedTime, K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime.optional.default(nil)

    # State of this Series: Ongoing or Finished
    # @return [K8s::API::Types::String,NilClass]
    attribute :state, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
