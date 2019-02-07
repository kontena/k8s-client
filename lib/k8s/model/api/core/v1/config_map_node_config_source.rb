# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ConfigMapNodeConfigSource < K8s::TypedResource
    # KubeletConfigKey declares which key of the referenced ConfigMap corresponds to the KubeletConfiguration structure This field is required in all cases.
    # @return [K8s::API::Types::String]
    attribute :kubeletConfigKey, K8s::API::Types::String

    # Name is the metadata.name of the referenced ConfigMap. This field is required in all cases.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Namespace is the metadata.namespace of the referenced ConfigMap. This field is required in all cases.
    # @return [K8s::API::Types::String]
    attribute :namespace, K8s::API::Types::String

    # ResourceVersion is the metadata.ResourceVersion of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
    # @return [K8s::API::Types::String,NilClass]
    attribute :resourceVersion, K8s::API::Types::String.optional.default(nil)

    # UID is the metadata.UID of the referenced ConfigMap. This field is forbidden in Node.Spec, and required in Node.Status.
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
