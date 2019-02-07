# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/downward_api_volume_file'

module K8s::Model::Api::Core::V1
  class DownwardAPIProjection < K8s::TypedResource
    # Items is a list of DownwardAPIVolume file
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::DownwardAPIVolumeFile),NilClass]
    attribute :items, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::DownwardAPIVolumeFile).optional.default(nil)

    register_paths []
  end
end
