# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class KeyToPath < K8s::TypedResource
    # The key to project.
    # @return [K8s::API::Types::String]
    attribute :key, K8s::API::Types::String

    # Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :mode, K8s::API::Types::Integer.optional.default(nil)

    # The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.
    # @return [K8s::API::Types::String]
    attribute :path, K8s::API::Types::String

    register_paths []
  end
end
