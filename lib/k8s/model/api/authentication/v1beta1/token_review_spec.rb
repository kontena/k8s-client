# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authentication/v1beta1"


module K8s::Model::Api::Authentication::V1beta1
  class TokenReviewSpec < K8s::TypedResource
    # Audiences is a list of the identifiers that the resource server presented with the token identifies as. Audience-aware token authenticators will verify that the token was intended for at least one of the audiences in this list. If no audiences are provided, the audience will default to the audience of the Kubernetes apiserver.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :audiences, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Token is the opaque bearer token.
    # @return [K8s::API::Types::String,NilClass]
    attribute :token, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
