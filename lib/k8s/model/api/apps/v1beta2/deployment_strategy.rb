# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/api/apps/v1beta2/rolling_update_deployment'

module K8s::Model::Api::Apps::V1beta2
  class DeploymentStrategy < K8s::TypedResource
    # Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.
    # @return [K8s::Model::Api::Apps::V1beta2::RollingUpdateDeployment,NilClass]
    attribute :rollingUpdate, K8s::Model::Api::Apps::V1beta2::RollingUpdateDeployment.optional.default(nil)

    # Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
