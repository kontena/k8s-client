# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"
require 'k8s/model/api/autoscaling/v2beta1/external_metric_status'
require 'k8s/model/api/autoscaling/v2beta1/object_metric_status'
require 'k8s/model/api/autoscaling/v2beta1/pods_metric_status'
require 'k8s/model/api/autoscaling/v2beta1/resource_metric_status'

module K8s::Model::Api::Autoscaling::V2beta1
  class MetricStatus < K8s::TypedResource
    # external refers to a global metric that is not associated with any Kubernetes object. It allows autoscaling based on information coming from components running outside of cluster (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).
    # @return [K8s::Model::Api::Autoscaling::V2beta1::ExternalMetricStatus,NilClass]
    attribute :external, K8s::Model::Api::Autoscaling::V2beta1::ExternalMetricStatus.optional.default(nil)

    # object refers to a metric describing a single kubernetes object (for example, hits-per-second on an Ingress object).
    # @return [K8s::Model::Api::Autoscaling::V2beta1::ObjectMetricStatus,NilClass]
    attribute :object, K8s::Model::Api::Autoscaling::V2beta1::ObjectMetricStatus.optional.default(nil)

    # pods refers to a metric describing each pod in the current scale target (for example, transactions-processed-per-second).  The values will be averaged together before being compared to the target value.
    # @return [K8s::Model::Api::Autoscaling::V2beta1::PodsMetricStatus,NilClass]
    attribute :pods, K8s::Model::Api::Autoscaling::V2beta1::PodsMetricStatus.optional.default(nil)

    # resource refers to a resource metric (such as those specified in requests and limits) known to Kubernetes describing each pod in the current scale target (e.g. CPU or memory). Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the "pods" source.
    # @return [K8s::Model::Api::Autoscaling::V2beta1::ResourceMetricStatus,NilClass]
    attribute :resource, K8s::Model::Api::Autoscaling::V2beta1::ResourceMetricStatus.optional.default(nil)

    # type is the type of metric source.  It will be one of "Object", "Pods" or "Resource", each corresponds to a matching field in the object.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
