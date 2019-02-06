# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class PersistentVolumeStatus < K8s::TypedResource
    # A human-readable message indicating details about why the volume is in this state.
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # Phase indicates if a volume is available, bound to a claim, or released by a claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#phase
    # @return [K8s::API::Types::String,NilClass]
    attribute :phase, K8s::API::Types::String.optional.default(nil)

    # Reason is a brief CamelCase string that describes any failure and is meant for machine parsing and tidy display in the CLI.
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
