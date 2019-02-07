# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/storage/v1alpha1"


module K8s::Model::Api::Storage::V1alpha1
  class VolumeAttachmentSource < K8s::TypedResource
    # Name of the persistent volume to attach.
    # @return [K8s::API::Types::String,NilClass]
    attribute :persistentVolumeName, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
