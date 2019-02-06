# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class SELinuxOptions < K8s::TypedResource
    # Level is SELinux level label that applies to the container.
    # @return [K8s::API::Types::String,NilClass]
    attribute :level, K8s::API::Types::String.optional.default(nil)

    # Role is a SELinux role label that applies to the container.
    # @return [K8s::API::Types::String,NilClass]
    attribute :role, K8s::API::Types::String.optional.default(nil)

    # Type is a SELinux type label that applies to the container.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    # User is a SELinux user label that applies to the container.
    # @return [K8s::API::Types::String,NilClass]
    attribute :user, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
