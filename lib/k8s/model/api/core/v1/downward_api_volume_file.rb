# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/object_field_selector'
require 'k8s/model/api/core/v1/resource_field_selector'

module K8s::Model::Api::Core::V1
  class DownwardAPIVolumeFile < K8s::TypedResource
    # Required: Selects a field of the pod: only annotations, labels, name and namespace are supported.
    # @return [K8s::Model::Api::Core::V1::ObjectFieldSelector,NilClass]
    attribute :fieldRef, K8s::Model::Api::Core::V1::ObjectFieldSelector.optional.default(nil)

    # Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :mode, K8s::API::Types::Integer.optional.default(nil)

    # Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'
    # @return [K8s::API::Types::String]
    attribute :path, K8s::API::Types::String

    # Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.
    # @return [K8s::Model::Api::Core::V1::ResourceFieldSelector,NilClass]
    attribute :resourceFieldRef, K8s::Model::Api::Core::V1::ResourceFieldSelector.optional.default(nil)

    register_paths []
  end
end
