# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1"
require 'k8s/model/api/apps/v1/rolling_update_stateful_set_strategy'

module K8s::Model::Api::Apps::V1
  class StatefulSetUpdateStrategy < K8s::TypedResource
    # RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.
    # @return [K8s::Model::Api::Apps::V1::RollingUpdateStatefulSetStrategy,NilClass]
    attribute :rollingUpdate, K8s::Model::Api::Apps::V1::RollingUpdateStatefulSetStrategy.optional.default(nil)

    # Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
