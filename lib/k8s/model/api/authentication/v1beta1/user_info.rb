# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authentication/v1beta1"


module K8s::Model::Api::Authentication::V1beta1
  class UserInfo < K8s::TypedResource
    # Any additional information provided by the authenticator.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :extra, K8s::API::Types::Hash.optional.default(nil)

    # The names of groups this user is a part of.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :groups, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # A unique value that identifies this user across time. If this user is deleted and another user by the same name is added, they will have different UIDs.
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    # The name that uniquely identifies this user among all active users.
    # @return [K8s::API::Types::String,NilClass]
    attribute :username, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
