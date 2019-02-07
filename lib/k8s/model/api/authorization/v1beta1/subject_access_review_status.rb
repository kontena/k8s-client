# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/authorization/v1beta1"


module K8s::Model::Api::Authorization::V1beta1
  class SubjectAccessReviewStatus < K8s::TypedResource
    # Allowed is required. True if the action would be allowed, false otherwise.
    # @return [K8s::API::Types::Bool]
    attribute :allowed, K8s::API::Types::Bool

    # Denied is optional. True if the action would be denied, otherwise false. If both allowed is false and denied is false, then the authorizer has no opinion on whether to authorize the action. Denied may not be true if Allowed is true.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :denied, K8s::API::Types::Bool.optional.default(nil)

    # EvaluationError is an indication that some error occurred during the authorization check. It is entirely possible to get an error and be able to continue determine authorization status in spite of it. For instance, RBAC can be missing a role, but enough roles are still present and bound to reason about the request.
    # @return [K8s::API::Types::String,NilClass]
    attribute :evaluationError, K8s::API::Types::String.optional.default(nil)

    # Reason is optional.  It indicates why a request was allowed or denied.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
