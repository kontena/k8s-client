# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1"


module K8s::Model::Api::Authorization::V1
  class SelfSubjectRulesReviewSpec < K8s::TypedResource
    # Namespace to evaluate rules for. Required.
    # @return [K8s::API::Types::String,NilClass]
    attribute :namespace, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
