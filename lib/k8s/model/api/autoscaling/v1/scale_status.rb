# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v1"


module K8s::Model::Api::Autoscaling::V1
  class ScaleStatus < K8s::TypedResource
    # actual number of observed instances of the scaled object.
    # @return [K8s::API::Types::Integer]
    attribute :replicas, K8s::API::Types::Integer

    # label query over pods that should match the replicas count. This is same as the label selector but in the string format to avoid introspection by clients. The string will be in the same format as the query-param syntax. More info about label selectors: http://kubernetes.io/docs/user-guide/labels#label-selectors
    # @return [K8s::API::Types::String,NilClass]
    attribute :selector, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
