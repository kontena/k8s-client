# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1"


module K8s::Model::Api::Authorization::V1
  class NonResourceRule < K8s::TypedResource
    # NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path.  "*" means all.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :nonResourceURLs, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Verb is a list of kubernetes non-resource API verbs, like: get, post, put, delete, patch, head, options.  "*" means all.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :verbs, K8s::API::Types::Array.of(K8s::API::Types::String)

    register_paths []
  end
end
