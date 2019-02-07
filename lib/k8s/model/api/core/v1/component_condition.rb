# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ComponentCondition < K8s::TypedResource
    # Condition error code for a component. For example, a health check error code.
    # @return [K8s::API::Types::String,NilClass]
    attribute :error, K8s::API::Types::String.optional.default(nil)

    # Message about the condition for a component. For example, information about a health check.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # Status of the condition for a component. Valid values for "Healthy": "True", "False", or "Unknown".
    # @return [K8s::API::Types::String]
    attribute :status, K8s::API::Types::String

    # Type of condition for a component. Valid value: "Healthy"
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths []
  end
end
