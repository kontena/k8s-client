# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/rolling_update_deployment'

module K8s::Model::Api::Extensions::V1beta1
  class DeploymentStrategy < K8s::TypedResource
    # Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.
    # @return [K8s::Model::Api::Extensions::V1beta1::RollingUpdateDeployment,NilClass]
    attribute :rollingUpdate, K8s::Model::Api::Extensions::V1beta1::RollingUpdateDeployment.optional.default(nil)

    # Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
