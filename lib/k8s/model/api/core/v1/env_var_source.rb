# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/config_map_key_selector'
require 'k8s/model/api/core/v1/object_field_selector'
require 'k8s/model/api/core/v1/resource_field_selector'
require 'k8s/model/api/core/v1/secret_key_selector'

module K8s::Model::Api::Core::V1
  class EnvVarSource < K8s::TypedResource
    # Selects a key of a ConfigMap.
    # @return [K8s::Model::Api::Core::V1::ConfigMapKeySelector,NilClass]
    attribute :configMapKeyRef, K8s::Model::Api::Core::V1::ConfigMapKeySelector.optional.default(nil)

    # Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP.
    # @return [K8s::Model::Api::Core::V1::ObjectFieldSelector,NilClass]
    attribute :fieldRef, K8s::Model::Api::Core::V1::ObjectFieldSelector.optional.default(nil)

    # Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.
    # @return [K8s::Model::Api::Core::V1::ResourceFieldSelector,NilClass]
    attribute :resourceFieldRef, K8s::Model::Api::Core::V1::ResourceFieldSelector.optional.default(nil)

    # Selects a key of a secret in the pod's namespace
    # @return [K8s::Model::Api::Core::V1::SecretKeySelector,NilClass]
    attribute :secretKeyRef, K8s::Model::Api::Core::V1::SecretKeySelector.optional.default(nil)

    register_paths [
      
    ]
  end
end
