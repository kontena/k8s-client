# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/authorization/v1beta1/self_subject_access_review_spec'
require 'k8s/model/api/authorization/v1beta1/subject_access_review_status'

module K8s::Model::Api::Authorization::V1beta1
  class SelfSubjectAccessReview < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # Spec holds information about the request being evaluated.  user and groups must be empty
    # @return [K8s::Model::Api::Authorization::V1beta1::SelfSubjectAccessReviewSpec]
    attribute :spec, K8s::Model::Api::Authorization::V1beta1::SelfSubjectAccessReviewSpec

    # Status is filled in by the server and indicates whether the request is allowed or not
    # @return [K8s::Model::Api::Authorization::V1beta1::SubjectAccessReviewStatus,NilClass]
    attribute :status, K8s::Model::Api::Authorization::V1beta1::SubjectAccessReviewStatus.optional.default(nil)

    register_paths []
  end
end
