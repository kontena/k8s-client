# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/kube_aggregator/apis/apiregistration/v1beta1"
require 'k8s/model/kube_aggregator/apis/apiregistration/v1beta1/api_service_condition'

module K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1
  class APIServiceStatus < K8s::TypedResource
    # Current service state of apiService.
    # @return [K8s::API::Types::Array.of(K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::APIServiceCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::APIServiceCondition).optional.default(nil)

    register_paths []
  end
end
