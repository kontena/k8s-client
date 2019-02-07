# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class AttachedVolume < K8s::TypedResource
    # DevicePath represents the device path where the volume should be available
    # @return [K8s::API::Types::String]
    attribute :devicePath, K8s::API::Types::String

    # Name of the attached volume
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    register_paths []
  end
end
