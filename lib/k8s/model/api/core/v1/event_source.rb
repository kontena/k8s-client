# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class EventSource < K8s::TypedResource
    # Component from which the event is generated.
    # @return [K8s::API::Types::String,NilClass]
    attribute :component, K8s::API::Types::String.optional.default(nil)

    # Node name on which the event is generated.
    # @return [K8s::API::Types::String,NilClass]
    attribute :host, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
