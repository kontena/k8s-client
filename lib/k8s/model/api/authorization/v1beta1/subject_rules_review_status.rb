# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1beta1"
require 'k8s/model/api/authorization/v1beta1/non_resource_rule'
require 'k8s/model/api/authorization/v1beta1/resource_rule'

module K8s::Model::Api::Authorization::V1beta1
  class SubjectRulesReviewStatus < K8s::TypedResource
    # EvaluationError can appear in combination with Rules. It indicates an error occurred during rule evaluation, such as an authorizer that doesn't support rule evaluation, and that ResourceRules and/or NonResourceRules may be incomplete.
    # @return [K8s::API::Types::String,NilClass]
    attribute :evaluationError, K8s::API::Types::String.optional.default(nil)

    # Incomplete is true when the rules returned by this call are incomplete. This is most commonly encountered when an authorizer, such as an external authorizer, doesn't support rules evaluation.
    # @return [K8s::API::Types::Bool]
    attribute :incomplete, K8s::API::Types::Bool

    # NonResourceRules is the list of actions the subject is allowed to perform on non-resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Authorization::V1beta1::NonResourceRule)]
    attribute :nonResourceRules, K8s::API::Types::Array.of(K8s::Model::Api::Authorization::V1beta1::NonResourceRule)

    # ResourceRules is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Authorization::V1beta1::ResourceRule)]
    attribute :resourceRules, K8s::API::Types::Array.of(K8s::Model::Api::Authorization::V1beta1::ResourceRule)

    register_paths []
  end
end
