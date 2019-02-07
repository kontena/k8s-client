# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/node_affinity'
require 'k8s/model/api/core/v1/pod_affinity'
require 'k8s/model/api/core/v1/pod_anti_affinity'

module K8s::Model::Api::Core::V1
  class Affinity < K8s::TypedResource
    # Describes node affinity scheduling rules for the pod.
    # @return [K8s::Model::Api::Core::V1::NodeAffinity,NilClass]
    attribute :nodeAffinity, K8s::Model::Api::Core::V1::NodeAffinity.optional.default(nil)

    # Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).
    # @return [K8s::Model::Api::Core::V1::PodAffinity,NilClass]
    attribute :podAffinity, K8s::Model::Api::Core::V1::PodAffinity.optional.default(nil)

    # Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).
    # @return [K8s::Model::Api::Core::V1::PodAntiAffinity,NilClass]
    attribute :podAntiAffinity, K8s::Model::Api::Core::V1::PodAntiAffinity.optional.default(nil)

    register_paths []
  end
end
