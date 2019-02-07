# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class HTTPHeader < K8s::TypedResource
    # The header field name
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # The header field value
    # @return [K8s::API::Types::String]
    attribute :value, K8s::API::Types::String

    register_paths []
  end
end
