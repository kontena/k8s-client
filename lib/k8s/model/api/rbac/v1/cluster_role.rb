# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/rbac/v1"
require 'k8s/model/api/rbac/v1/aggregation_rule'
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/rbac/v1/policy_rule'

module K8s::Model::Api::Rbac::V1
  class ClusterRole < K8s::TypedResource
    # AggregationRule is an optional field that describes how to build the Rules for this ClusterRole. If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be stomped by the controller.
    # @return [K8s::Model::Api::Rbac::V1::AggregationRule,NilClass]
    attribute :aggregationRule, K8s::Model::Api::Rbac::V1::AggregationRule.optional.default(nil)

    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Rules holds all the PolicyRules for this ClusterRole
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Rbac::V1::PolicyRule)]
    attribute :rules, K8s::API::Types::Array.of(K8s::Model::Api::Rbac::V1::PolicyRule)

    register_paths ["/apis/rbac.authorization.k8s.io/v1/clusterroles/{name}"]
  end
end
