# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class PodReadinessGate < K8s::TypedResource
    # ConditionType refers to a condition in the pod's condition list with matching type.
    # @return [K8s::API::Types::String]
    attribute :conditionType, K8s::API::Types::String

    register_paths []
  end
end
