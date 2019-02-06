# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/kube_aggregator/apis/apiregistration/v1"


module K8s::Model::KubeAggregator::Apis::Apiregistration::V1
  class ServiceReference < K8s::TypedResource
    # Name is the name of the service
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # Namespace is the namespace of the service
    # @return [K8s::API::Types::String,NilClass]
    attribute :namespace, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
