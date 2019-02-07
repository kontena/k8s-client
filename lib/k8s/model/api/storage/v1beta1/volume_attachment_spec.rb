# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/storage/v1beta1"
require 'k8s/model/api/storage/v1beta1/volume_attachment_source'

module K8s::Model::Api::Storage::V1beta1
  class VolumeAttachmentSpec < K8s::TypedResource
    # Attacher indicates the name of the volume driver that MUST handle this request. This is the name returned by GetPluginName().
    # @return [K8s::API::Types::String]
    attribute :attacher, K8s::API::Types::String

    # The node that the volume should be attached to.
    # @return [K8s::API::Types::String]
    attribute :nodeName, K8s::API::Types::String

    # Source represents the volume that should be attached.
    # @return [K8s::Model::Api::Storage::V1beta1::VolumeAttachmentSource]
    attribute :source, K8s::Model::Api::Storage::V1beta1::VolumeAttachmentSource

    register_paths []
  end
end
