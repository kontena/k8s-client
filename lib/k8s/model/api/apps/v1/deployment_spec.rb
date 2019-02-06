# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/apps/v1/deployment_strategy'
require 'k8s/model/api/core/v1/pod_template_spec'

module K8s::Model::Api::Apps::V1
  class DeploymentSpec < K8s::TypedResource
    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minReadySeconds, K8s::API::Types::Integer.optional.default(nil)

    # Indicates that the deployment is paused.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :paused, K8s::API::Types::Bool.optional.default(nil)

    # The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :progressDeadlineSeconds, K8s::API::Types::Integer.optional.default(nil)

    # Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :replicas, K8s::API::Types::Integer.optional.default(nil)

    # The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :revisionHistoryLimit, K8s::API::Types::Integer.optional.default(nil)

    # Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector

    # The deployment strategy to use to replace existing pods with new ones.
    # @return [K8s::Model::Api::Apps::V1::DeploymentStrategy,NilClass]
    attribute :strategy, K8s::Model::Api::Apps::V1::DeploymentStrategy.optional.default(nil)

    # Template describes the pods that will be created.
    # @return [K8s::Model::Api::Core::V1::PodTemplateSpec]
    attribute :template, K8s::Model::Api::Core::V1::PodTemplateSpec

    register_paths [
      
    ]
  end
end
