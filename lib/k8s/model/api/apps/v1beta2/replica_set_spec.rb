# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/core/v1/pod_template_spec'

module K8s::Model::Api::Apps::V1beta2
  class ReplicaSetSpec < K8s::TypedResource
    # Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minReadySeconds, K8s::API::Types::Integer.optional.default(nil)

    # Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :replicas, K8s::API::Types::Integer.optional.default(nil)

    # Selector is a label query over pods that should match the replica count. Label keys and values that must match in order to be controlled by this replica set. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector

    # Template is the object that describes the pod that will be created if insufficient replicas are detected. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
    # @return [K8s::Model::Api::Core::V1::PodTemplateSpec,NilClass]
    attribute :template, K8s::Model::Api::Core::V1::PodTemplateSpec.optional.default(nil)

    register_paths [
      
    ]
  end
end
