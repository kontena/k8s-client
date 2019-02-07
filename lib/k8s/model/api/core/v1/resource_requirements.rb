# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ResourceRequirements < K8s::TypedResource
    # Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :limits, K8s::API::Types::Hash.optional.default(nil)

    # Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :requests, K8s::API::Types::Hash.optional.default(nil)

    register_paths []
  end
end
