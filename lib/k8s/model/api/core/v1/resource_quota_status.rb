# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ResourceQuotaStatus < K8s::TypedResource
    # Hard is the set of enforced hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :hard, K8s::API::Types::Hash.optional.default(nil)

    # Used is the current observed total usage of the resource in the namespace.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :used, K8s::API::Types::Hash.optional.default(nil)

    register_paths [
      
    ]
  end
end
