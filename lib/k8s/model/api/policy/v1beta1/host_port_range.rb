# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/policy/v1beta1"


module K8s::Model::Api::Policy::V1beta1
  class HostPortRange < K8s::TypedResource
    # max is the end of the range, inclusive.
    # @return [K8s::API::Types::Integer]
    attribute :max, K8s::API::Types::Integer

    # min is the start of the range, inclusive.
    # @return [K8s::API::Types::Integer]
    attribute :min, K8s::API::Types::Integer

    register_paths []
  end
end
