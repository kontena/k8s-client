# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/kube_aggregator/apis/apiregistration/v1beta1"
require 'k8s/model/kube_aggregator/apis/apiregistration/v1beta1/service_reference'

module K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1
  class APIServiceSpec < K8s::TypedResource
    # CABundle is a PEM encoded CA bundle which will be used to validate an API server's serving certificate. If unspecified, system trust roots on the apiserver are used.
    # @return [K8s::API::Types::String,NilClass]
    attribute :caBundle, K8s::API::Types::String.optional.default(nil)

    # Group is the API group name this server hosts
    # @return [K8s::API::Types::String,NilClass]
    attribute :group, K8s::API::Types::String.optional.default(nil)

    # GroupPriorityMininum is the priority this group should have at least. Higher priority means that the group is preferred by clients over lower priority ones. Note that other versions of this group might specify even higher GroupPriorityMininum values such that the whole group gets a higher priority. The primary sort is based on GroupPriorityMinimum, ordered highest number to lowest (20 before 10). The secondary sort is based on the alphabetical comparison of the name of the object.  (v1.bar before v1.foo) We'd recommend something like: *.k8s.io (except extensions) at 18000 and PaaSes (OpenShift, Deis) are recommended to be in the 2000s
    # @return [K8s::API::Types::Integer]
    attribute :groupPriorityMinimum, K8s::API::Types::Integer

    # InsecureSkipTLSVerify disables TLS certificate verification when communicating with this server. This is strongly discouraged.  You should use the CABundle instead.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :insecureSkipTLSVerify, K8s::API::Types::Bool.optional.default(nil)

    # Service is a reference to the service for this API server.  It must communicate on port 443 If the Service is nil, that means the handling for the API groupversion is handled locally on this server. The call will simply delegate to the normal handler chain to be fulfilled.
    # @return [K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::ServiceReference]
    attribute :service, K8s::Model::KubeAggregator::Apis::Apiregistration::V1beta1::ServiceReference

    # Version is the API version this server hosts.  For example, "v1"
    # @return [K8s::API::Types::String,NilClass]
    attribute :version, K8s::API::Types::String.optional.default(nil)

    # VersionPriority controls the ordering of this API version inside of its group.  Must be greater than zero. The primary sort is based on VersionPriority, ordered highest to lowest (20 before 10). Since it's inside of a group, the number can be small, probably in the 10s. In case of equal version priorities, the version string will be used to compute the order inside a group. If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version), then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing major version, then minor version. An example sorted list of versions: v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
    # @return [K8s::API::Types::Integer]
    attribute :versionPriority, K8s::API::Types::Integer

    register_paths [
      
    ]
  end
end
