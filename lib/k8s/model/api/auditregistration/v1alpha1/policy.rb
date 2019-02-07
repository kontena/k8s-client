# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/auditregistration/v1alpha1"


module K8s::Model::Api::Auditregistration::V1alpha1
  class Policy < K8s::TypedResource
    # The Level that all requests are recorded at. available options: None, Metadata, Request, RequestResponse required
    # @return [K8s::API::Types::String]
    attribute :level, K8s::API::Types::String

    # Stages is a list of stages for which events are created.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :stages, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths []
  end
end
