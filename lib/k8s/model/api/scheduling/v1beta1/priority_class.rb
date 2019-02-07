# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/scheduling/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'

module K8s::Model::Api::Scheduling::V1beta1
  class PriorityClass < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # description is an arbitrary string that usually provides guidelines on when this priority class should be used.
    # @return [K8s::API::Types::String,NilClass]
    attribute :description, K8s::API::Types::String.optional.default(nil)

    # globalDefault specifies whether this PriorityClass should be considered as the default priority for pods that do not have any priority class. Only one PriorityClass can be marked as `globalDefault`. However, if more than one PriorityClasses exists with their `globalDefault` field set to true, the smallest value of such global default PriorityClasses will be used as the default priority.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :globalDefault, K8s::API::Types::Bool.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # The value of this priority class. This is the actual priority that pods receive when they have the name of this class in their pod spec.
    # @return [K8s::API::Types::Integer]
    attribute :value, K8s::API::Types::Integer

    register_paths ["/apis/scheduling.k8s.io/v1beta1/priorityclasses/{name}"]
  end
end
