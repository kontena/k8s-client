# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class FlockerVolumeSource < K8s::TypedResource
    # Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated
    # @return [K8s::API::Types::String,NilClass]
    attribute :datasetName, K8s::API::Types::String.optional.default(nil)

    # UUID of the dataset. This is unique identifier of a Flocker dataset
    # @return [K8s::API::Types::String,NilClass]
    attribute :datasetUUID, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
