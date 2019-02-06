# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/config_map_node_config_source'

module K8s::Model::Api::Core::V1
  class NodeConfigSource < K8s::TypedResource
    # ConfigMap is a reference to a Node's ConfigMap
    # @return [K8s::Model::Api::Core::V1::ConfigMapNodeConfigSource,NilClass]
    attribute :configMap, K8s::Model::Api::Core::V1::ConfigMapNodeConfigSource.optional.default(nil)

    register_paths [
      
    ]
  end
end
