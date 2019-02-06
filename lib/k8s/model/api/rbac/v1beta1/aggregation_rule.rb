# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/rbac/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'

module K8s::Model::Api::Rbac::V1beta1
  class AggregationRule < K8s::TypedResource
    # ClusterRoleSelectors holds a list of selectors which will be used to find ClusterRoles and create the rules. If any of the selectors match, then the ClusterRole's permissions will be added
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector),NilClass]
    attribute :clusterRoleSelectors, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector).optional.default(nil)

    register_paths [
      
    ]
  end
end
