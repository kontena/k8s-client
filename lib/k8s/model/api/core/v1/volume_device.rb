# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class VolumeDevice < K8s::TypedResource
    # devicePath is the path inside of the container that the device will be mapped to.
    # @return [K8s::API::Types::String]
    attribute :devicePath, K8s::API::Types::String

    # name must match the name of a persistentVolumeClaim in the pod
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    register_paths []
  end
end
