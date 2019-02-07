# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/core/v1/pod_template_spec'
require 'k8s/model/api/apps/v1beta2/daemon_set_update_strategy'

module K8s::Model::Api::Apps::V1beta2
  class DaemonSetSpec < K8s::TypedResource
    # The minimum number of seconds for which a newly created DaemonSet pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready).
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :minReadySeconds, K8s::API::Types::Integer.optional.default(nil)

    # The number of old history to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :revisionHistoryLimit, K8s::API::Types::Integer.optional.default(nil)

    # A label query over pods that are managed by the daemon set. Must match in order to be controlled. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector

    # An object that describes the pod that will be created. The DaemonSet will create exactly one copy of this pod on every node that matches the template's node selector (or on every node if no node selector is specified). More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template
    # @return [K8s::Model::Api::Core::V1::PodTemplateSpec]
    attribute :template, K8s::Model::Api::Core::V1::PodTemplateSpec

    # An update strategy to replace existing DaemonSet pods with new pods.
    # @return [K8s::Model::Api::Apps::V1beta2::DaemonSetUpdateStrategy,NilClass]
    attribute :updateStrategy, K8s::Model::Api::Apps::V1beta2::DaemonSetUpdateStrategy.optional.default(nil)

    register_paths []
  end
end
