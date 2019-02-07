# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class PodDNSConfigOption < K8s::TypedResource
    # Required.
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :value, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
