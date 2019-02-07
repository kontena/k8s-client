# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/core/v1/pod_template_spec'
require 'k8s/model/api/apps/v1/stateful_set_update_strategy'
require 'k8s/model/api/core/v1/persistent_volume_claim'

module K8s::Model::Api::Apps::V1
  class StatefulSetSpec < K8s::TypedResource
    # podManagementPolicy controls how pods are created during initial scale up, when replacing pods on nodes, or when scaling down. The default policy is `OrderedReady`, where pods are created in increasing order (pod-0, then pod-1, etc) and the controller will wait until each pod is ready before continuing. When scaling down, the pods are removed in the opposite order. The alternative policy is `Parallel` which will create pods in parallel to match the desired scale without waiting, and on scale down will delete all pods at once.
    # @return [K8s::API::Types::String,NilClass]
    attribute :podManagementPolicy, K8s::API::Types::String.optional.default(nil)

    # replicas is the desired number of replicas of the given Template. These are replicas in the sense that they are instantiations of the same Template, but individual replicas also have a consistent identity. If unspecified, defaults to 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :replicas, K8s::API::Types::Integer.optional.default(nil)

    # revisionHistoryLimit is the maximum number of revisions that will be maintained in the StatefulSet's revision history. The revision history consists of all revisions not represented by a currently applied StatefulSetSpec version. The default value is 10.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :revisionHistoryLimit, K8s::API::Types::Integer.optional.default(nil)

    # selector is a label query over pods that should match the replica count. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector

    # serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set. Pods get DNS/hostnames that follow the pattern: pod-specific-string.serviceName.default.svc.cluster.local where "pod-specific-string" is managed by the StatefulSet controller.
    # @return [K8s::API::Types::String]
    attribute :serviceName, K8s::API::Types::String

    # template is the object that describes the pod that will be created if insufficient replicas are detected. Each pod stamped out by the StatefulSet will fulfill this Template, but have a unique identity from the rest of the StatefulSet.
    # @return [K8s::Model::Api::Core::V1::PodTemplateSpec]
    attribute :template, K8s::Model::Api::Core::V1::PodTemplateSpec

    # updateStrategy indicates the StatefulSetUpdateStrategy that will be employed to update Pods in the StatefulSet when a revision is made to Template.
    # @return [K8s::Model::Api::Apps::V1::StatefulSetUpdateStrategy,NilClass]
    attribute :updateStrategy, K8s::Model::Api::Apps::V1::StatefulSetUpdateStrategy.optional.default(nil)

    # volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PersistentVolumeClaim),NilClass]
    attribute :volumeClaimTemplates, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PersistentVolumeClaim).optional.default(nil)

    register_paths []
  end
end
