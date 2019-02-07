# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/admissionregistration/v1beta1"


module K8s::Model::Api::Admissionregistration::V1beta1
  class RuleWithOperations < K8s::TypedResource
    # APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :apiGroups, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :apiVersions, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Operations is the operations the admission hook cares about - CREATE, UPDATE, or * for all operations. If '*' is present, the length of the slice must be one. Required.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :operations, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Resources is a list of resources this rule applies to.

    # For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.

    # If wildcard is present, the validation rule will ensure resources do not overlap with each other.

    # Depending on the enclosing object, subresources might not be allowed. Required.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :resources, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths []
  end
end
