# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/core/v1/se_linux_options'

module K8s::Model::Api::Extensions::V1beta1
  class SELinuxStrategyOptions < K8s::TypedResource
    # rule is the strategy that will dictate the allowable labels that may be set.
    # @return [K8s::API::Types::String]
    attribute :rule, K8s::API::Types::String

    # seLinuxOptions required to run as; required for MustRunAs More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
    # @return [K8s::Model::Api::Core::V1::SELinuxOptions,NilClass]
    attribute :seLinuxOptions, K8s::Model::Api::Core::V1::SELinuxOptions.optional.default(nil)

    register_paths []
  end
end
