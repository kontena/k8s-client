# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authentication/v1beta1"
require 'k8s/model/api/authentication/v1beta1/user_info'

module K8s::Model::Api::Authentication::V1beta1
  class TokenReviewStatus < K8s::TypedResource
    # Audiences are audience identifiers chosen by the authenticator that are compatible with both the TokenReview and token. An identifier is any identifier in the intersection of the TokenReviewSpec audiences and the token's audiences. A client of the TokenReview API that sets the spec.audiences field should validate that a compatible audience identifier is returned in the status.audiences field to ensure that the TokenReview server is audience aware. If a TokenReview returns an empty status.audience field where status.authenticated is "true", the token is valid against the audience of the Kubernetes API server.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :audiences, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Authenticated indicates that the token was associated with a known user.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :authenticated, K8s::API::Types::Bool.optional.default(nil)

    # Error indicates that the token couldn't be checked
    # @return [K8s::API::Types::String,NilClass]
    attribute :error, K8s::API::Types::String.optional.default(nil)

    # User is the UserInfo associated with the provided token.
    # @return [K8s::Model::Api::Authentication::V1beta1::UserInfo,NilClass]
    attribute :user, K8s::Model::Api::Authentication::V1beta1::UserInfo.optional.default(nil)

    register_paths [
      
    ]
  end
end
