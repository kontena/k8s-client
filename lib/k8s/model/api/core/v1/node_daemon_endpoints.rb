# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/daemon_endpoint'

module K8s::Model::Api::Core::V1
  class NodeDaemonEndpoints < K8s::TypedResource
    # Endpoint on which Kubelet is listening.
    # @return [K8s::Model::Api::Core::V1::DaemonEndpoint,NilClass]
    attribute :kubeletEndpoint, K8s::Model::Api::Core::V1::DaemonEndpoint.optional.default(nil)

    register_paths []
  end
end
