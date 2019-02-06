# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class DaemonEndpoint < K8s::TypedResource
    # Port number of the given endpoint.
    # @return [K8s::API::Types::Integer]
    attribute :Port, K8s::API::Types::Integer

    register_paths [
      
    ]
  end
end
