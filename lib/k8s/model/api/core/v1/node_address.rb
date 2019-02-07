# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class NodeAddress < K8s::TypedResource
    # The node address.
    # @return [K8s::API::Types::String]
    attribute :address, K8s::API::Types::String

    # Node address type, one of Hostname, ExternalIP or InternalIP.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths []
  end
end
