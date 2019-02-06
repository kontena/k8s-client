# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Core::V1
  class Taint < K8s::TypedResource
    # Required. The effect of the taint on pods that do not tolerate the taint. Valid effects are NoSchedule, PreferNoSchedule and NoExecute.
    # @return [K8s::API::Types::String]
    attribute :effect, K8s::API::Types::String

    # Required. The taint key to be applied to a node.
    # @return [K8s::API::Types::String]
    attribute :key, K8s::API::Types::String

    # TimeAdded represents the time at which the taint was added. It is only written for NoExecute taints.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :timeAdded, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # Required. The taint value corresponding to the taint key.
    # @return [K8s::API::Types::String,NilClass]
    attribute :value, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
