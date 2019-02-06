# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta1"


module K8s::Model::Api::Apps::V1beta1
  class ScaleSpec < K8s::TypedResource
    # desired number of instances for the scaled object.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :replicas, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
