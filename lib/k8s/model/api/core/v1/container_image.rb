# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ContainerImage < K8s::TypedResource
    # Names by which this image is known. e.g. ["k8s.gcr.io/hyperkube:v1.0.7", "dockerhub.io/google_containers/hyperkube:v1.0.7"]
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :names, K8s::API::Types::Array.of(K8s::API::Types::String)

    # The size of the image in bytes.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :sizeBytes, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
