# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/storage/v1"
require 'k8s/model/api/storage/v1/volume_error'

module K8s::Model::Api::Storage::V1
  class VolumeAttachmentStatus < K8s::TypedResource
    # The last error encountered during attach operation, if any. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    # @return [K8s::Model::Api::Storage::V1::VolumeError,NilClass]
    attribute :attachError, K8s::Model::Api::Storage::V1::VolumeError.optional.default(nil)

    # Indicates the volume is successfully attached. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    # @return [K8s::API::Types::Bool]
    attribute :attached, K8s::API::Types::Bool

    # Upon successful attach, this field is populated with any information returned by the attach operation that must be passed into subsequent WaitForAttach or Mount calls. This field must only be set by the entity completing the attach operation, i.e. the external-attacher.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :attachmentMetadata, K8s::API::Types::Hash.optional.default(nil)

    # The last error encountered during detach operation, if any. This field must only be set by the entity completing the detach operation, i.e. the external-attacher.
    # @return [K8s::Model::Api::Storage::V1::VolumeError,NilClass]
    attribute :detachError, K8s::Model::Api::Storage::V1::VolumeError.optional.default(nil)

    register_paths []
  end
end
