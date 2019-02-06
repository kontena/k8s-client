# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/ip_block'
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Extensions::V1beta1
  class NetworkPolicyPeer < K8s::TypedResource
    # IPBlock defines policy on a particular IPBlock. If this field is set then neither of the other fields can be.
    # @return [K8s::Model::Api::Extensions::V1beta1::IPBlock,NilClass]
    attribute :ipBlock, K8s::Model::Api::Extensions::V1beta1::IPBlock.optional.default(nil)

    # Selects Namespaces using cluster-scoped labels. This field follows standard label selector semantics; if present but empty, it selects all namespaces.

    # If PodSelector is also set, then the NetworkPolicyPeer as a whole selects the Pods matching PodSelector in the Namespaces selected by NamespaceSelector. Otherwise it selects all Pods in the Namespaces selected by NamespaceSelector.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :namespaceSelector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # This is a label selector which selects Pods. This field follows standard label selector semantics; if present but empty, it selects all pods.

    # If NamespaceSelector is also set, then the NetworkPolicyPeer as a whole selects the Pods matching PodSelector in the Namespaces selected by NamespaceSelector. Otherwise it selects the Pods matching PodSelector in the policy's own Namespace.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :podSelector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    register_paths [
      
    ]
  end
end
