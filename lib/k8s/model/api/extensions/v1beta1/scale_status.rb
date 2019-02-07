# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"


module K8s::Model::Api::Extensions::V1beta1
  class ScaleStatus < K8s::TypedResource
    # actual number of observed instances of the scaled object.
    # @return [K8s::API::Types::Integer]
    attribute :replicas, K8s::API::Types::Integer

    # label query over pods that should match the replicas count. More info: http://kubernetes.io/docs/user-guide/labels#label-selectors
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :selector, K8s::API::Types::Hash.optional.default(nil)

    # label selector for pods that should match the replicas count. This is a serializated version of both map-based and more expressive set-based selectors. This is done to avoid introspection in the clients. The string will be in the same format as the query-param syntax. If the target type only supports map-based selectors, both this field and map-based selector field are populated. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    # @return [K8s::API::Types::String,NilClass]
    attribute :targetSelector, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
