# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/volume_projection'

module K8s::Model::Api::Core::V1
  class ProjectedVolumeSource < K8s::TypedResource
    # Mode bits to use on created files by default. Must be a value between 0 and 0777. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :defaultMode, K8s::API::Types::Integer.optional.default(nil)

    # list of volume projections
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeProjection)]
    attribute :sources, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeProjection)

    register_paths [
      
    ]
  end
end
