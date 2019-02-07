# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class AzureFileVolumeSource < K8s::TypedResource
    # Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # the name of secret that contains Azure Storage Account Name and Key
    # @return [K8s::API::Types::String]
    attribute :secretName, K8s::API::Types::String

    # Share Name
    # @return [K8s::API::Types::String]
    attribute :shareName, K8s::API::Types::String

    register_paths []
  end
end
