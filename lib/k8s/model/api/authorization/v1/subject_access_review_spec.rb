# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1"
require 'k8s/model/api/authorization/v1/non_resource_attributes'
require 'k8s/model/api/authorization/v1/resource_attributes'

module K8s::Model::Api::Authorization::V1
  class SubjectAccessReviewSpec < K8s::TypedResource
    # Extra corresponds to the user.Info.GetExtra() method from the authenticator.  Since that is input to the authorizer it needs a reflection here.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :extra, K8s::API::Types::Hash.optional.default(nil)

    # Groups is the groups you're testing for.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :groups, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # NonResourceAttributes describes information for a non-resource access request
    # @return [K8s::Model::Api::Authorization::V1::NonResourceAttributes,NilClass]
    attribute :nonResourceAttributes, K8s::Model::Api::Authorization::V1::NonResourceAttributes.optional.default(nil)

    # ResourceAuthorizationAttributes describes information for a resource access request
    # @return [K8s::Model::Api::Authorization::V1::ResourceAttributes,NilClass]
    attribute :resourceAttributes, K8s::Model::Api::Authorization::V1::ResourceAttributes.optional.default(nil)

    # UID information about the requesting user.
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    # User is the user you're testing for. If you specify "User" but not "Groups", then is it interpreted as "What if User were not a member of any groups
    # @return [K8s::API::Types::String,NilClass]
    attribute :user, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
