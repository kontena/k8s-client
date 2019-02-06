# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/downward_api_volume_file'

module K8s::Model::Api::Core::V1
  class DownwardAPIVolumeSource < K8s::TypedResource
    # Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :defaultMode, K8s::API::Types::Integer.optional.default(nil)

    # Items is a list of downward API volume file
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::DownwardAPIVolumeFile),NilClass]
    attribute :items, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::DownwardAPIVolumeFile).optional.default(nil)

    register_paths [
      
    ]
  end
end
