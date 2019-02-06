# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'

module K8s::Model::Api::Core::V1
  class ConfigMap < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :binaryData, K8s::API::Types::Hash.optional.default(nil)

    # Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :data, K8s::API::Types::Hash.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    register_paths [
      '/api/v1/namespaces/{namespace}/configmaps/{name}'
    ]
  end
end
