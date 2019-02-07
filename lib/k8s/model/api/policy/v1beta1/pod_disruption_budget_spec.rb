# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/policy/v1beta1"
require 'k8s/model/apimachinery/util/intstr/int_or_string'
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Policy::V1beta1
  class PodDisruptionBudgetSpec < K8s::TypedResource
    # An eviction is allowed if at most "maxUnavailable" pods selected by "selector" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with "minAvailable".
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString,NilClass]
    attribute :maxUnavailable, K8s::Model::Apimachinery::Util::Intstr::IntOrString.optional.default(nil)

    # An eviction is allowed if at least "minAvailable" pods selected by "selector" will still be available after the eviction, i.e. even in the absence of the evicted pod.  So for example you can prevent all voluntary evictions by specifying "100%".
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString,NilClass]
    attribute :minAvailable, K8s::Model::Apimachinery::Util::Intstr::IntOrString.optional.default(nil)

    # Label query over pods whose evictions are managed by the disruption budget.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    register_paths []
  end
end
