# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1"
require 'k8s/model/api/authorization/v1/non_resource_attributes'
require 'k8s/model/api/authorization/v1/resource_attributes'

module K8s::Model::Api::Authorization::V1
  class SelfSubjectAccessReviewSpec < K8s::TypedResource
    # NonResourceAttributes describes information for a non-resource access request
    # @return [K8s::Model::Api::Authorization::V1::NonResourceAttributes,NilClass]
    attribute :nonResourceAttributes, K8s::Model::Api::Authorization::V1::NonResourceAttributes.optional.default(nil)

    # ResourceAuthorizationAttributes describes information for a resource access request
    # @return [K8s::Model::Api::Authorization::V1::ResourceAttributes,NilClass]
    attribute :resourceAttributes, K8s::Model::Api::Authorization::V1::ResourceAttributes.optional.default(nil)

    register_paths []
  end
end
