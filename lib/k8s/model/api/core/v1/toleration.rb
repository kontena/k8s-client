# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class Toleration < K8s::TypedResource
    # Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.
    # @return [K8s::API::Types::String,NilClass]
    attribute :effect, K8s::API::Types::String.optional.default(nil)

    # Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.
    # @return [K8s::API::Types::String,NilClass]
    attribute :key, K8s::API::Types::String.optional.default(nil)

    # Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.
    # @return [K8s::API::Types::String,NilClass]
    attribute :operator, K8s::API::Types::String.optional.default(nil)

    # TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :tolerationSeconds, K8s::API::Types::Integer.optional.default(nil)

    # Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.
    # @return [K8s::API::Types::String,NilClass]
    attribute :value, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
