# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/kube_aggregator/apis/apiregistration/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/kube_aggregator/apis/apiregistration/v1beta1/api_service_spec'
require 'k8s/model/kube_aggregator/apis/apiregistration/v1beta1/api_service_status'

module K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1
  class APIService < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec contains information for locating and communicating with a server
    # @return [K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::APIServiceSpec,NilClass]
    attribute :spec, K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::APIServiceSpec.optional.default(nil)

    # Status contains derived information about an API server
    # @return [K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::APIServiceStatus,NilClass]
    attribute :status, K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::APIServiceStatus.optional.default(nil)

    register_paths ["/apis/apiregistration.k8s.io/v1beta1/apiservices/{name}","/apis/apiregistration.k8s.io/v1beta1/apiservices/{name}/status"]
  end
end
