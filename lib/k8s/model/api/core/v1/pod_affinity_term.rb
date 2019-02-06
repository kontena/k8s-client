# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Core::V1
  class PodAffinityTerm < K8s::TypedResource
    # A label query over a set of resources, in this case pods.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :labelSelector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means "this pod's namespace"
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :namespaces, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.
    # @return [K8s::API::Types::String]
    attribute :topologyKey, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
