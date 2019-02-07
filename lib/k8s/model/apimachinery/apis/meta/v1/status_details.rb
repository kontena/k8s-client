# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/status_cause'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class StatusDetails < K8s::TypedResource
    # The Causes array includes more details associated with the StatusReason failure. Not all StatusReasons may provide detailed causes.
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::StatusCause),NilClass]
    attribute :causes, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::StatusCause).optional.default(nil)

    # The group attribute of the resource associated with the status StatusReason.
    # @return [K8s::API::Types::String,NilClass]
    attribute :group, K8s::API::Types::String.optional.default(nil)

    # The kind attribute of the resource associated with the status StatusReason. On some operations may differ from the requested resource Kind. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # The name attribute of the resource associated with the status StatusReason (when there is a single name which can be described).
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # If specified, the time in seconds before the operation should be retried. Some errors may indicate the client must take an alternate action - for those errors this field may indicate how long to wait before taking the alternate action.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :retryAfterSeconds, K8s::API::Types::Integer.optional.default(nil)

    # UID of the resource. (when there is a single resource which can be described). More info: http://kubernetes.io/docs/user-guide/identifiers#uids
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
