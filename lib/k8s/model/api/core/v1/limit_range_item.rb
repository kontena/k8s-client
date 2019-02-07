# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class LimitRangeItem < K8s::TypedResource
    # Default resource requirement limit value by resource name if resource limit is omitted.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :default, K8s::API::Types::Hash.optional.default(nil)

    # DefaultRequest is the default resource requirement request value by resource name if resource request is omitted.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :defaultRequest, K8s::API::Types::Hash.optional.default(nil)

    # Max usage constraints on this kind by resource name.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :max, K8s::API::Types::Hash.optional.default(nil)

    # MaxLimitRequestRatio if specified, the named resource must have a request and limit that are both non-zero where limit divided by request is less than or equal to the enumerated value; this represents the max burst for the named resource.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :maxLimitRequestRatio, K8s::API::Types::Hash.optional.default(nil)

    # Min usage constraints on this kind by resource name.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :min, K8s::API::Types::Hash.optional.default(nil)

    # Type of resource that this limit applies to.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
