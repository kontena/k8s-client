# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1beta1"


module K8s::Model::Api::Authorization::V1beta1
  class NonResourceAttributes < K8s::TypedResource
    # Path is the URL path of the request
    # @return [K8s::API::Types::String,NilClass]
    attribute :path, K8s::API::Types::String.optional.default(nil)

    # Verb is the standard HTTP verb
    # @return [K8s::API::Types::String,NilClass]
    attribute :verb, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
