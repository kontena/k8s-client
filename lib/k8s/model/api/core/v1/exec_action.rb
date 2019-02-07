# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ExecAction < K8s::TypedResource
    # Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :command, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths []
  end
end
