# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/autoscaling/v2beta1"


module K8s::Model::Api::Autoscaling::V2beta1
  class CrossVersionObjectReference < K8s::TypedResource
    # API version of the referent
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind of the referent; More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds"
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # Name of the referent; More info: http://kubernetes.io/docs/user-guide/identifiers#names
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
