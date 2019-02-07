# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class QuobyteVolumeSource < K8s::TypedResource
    # Group to map volume access to Default is no group
    # @return [K8s::API::Types::String,NilClass]
    attribute :group, K8s::API::Types::String.optional.default(nil)

    # ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    # Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes
    # @return [K8s::API::Types::String]
    attribute :registry, K8s::API::Types::String

    # User to map volume access to Defaults to serivceaccount user
    # @return [K8s::API::Types::String,NilClass]
    attribute :user, K8s::API::Types::String.optional.default(nil)

    # Volume is a string that references an already created Quobyte volume by name.
    # @return [K8s::API::Types::String]
    attribute :volume, K8s::API::Types::String

    register_paths []
  end
end
