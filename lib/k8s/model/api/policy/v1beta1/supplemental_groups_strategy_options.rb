# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/policy/v1beta1"
require 'k8s/model/api/policy/v1beta1/id_range'

module K8s::Model::Api::Policy::V1beta1
  class SupplementalGroupsStrategyOptions < K8s::TypedResource
    # ranges are the allowed ranges of supplemental groups.  If you would like to force a single supplemental group then supply a single range with the same start and end. Required for MustRunAs.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Policy::V1beta1::IDRange),NilClass]
    attribute :ranges, K8s::API::Types::Array.of(K8s::Model::Api::Policy::V1beta1::IDRange).optional.default(nil)

    # rule is the strategy that will dictate what supplemental groups is used in the SecurityContext.
    # @return [K8s::API::Types::String,NilClass]
    attribute :rule, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
