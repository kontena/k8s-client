# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/handler'

module K8s::Model::Api::Core::V1
  class Lifecycle < K8s::TypedResource
    # PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
    # @return [K8s::Model::Api::Core::V1::Handler,NilClass]
    attribute :postStart, K8s::Model::Api::Core::V1::Handler.optional.default(nil)

    # PreStop is called immediately before a container is terminated. The container is terminated after the handler completes. The reason for termination is passed to the handler. Regardless of the outcome of the handler, the container is eventually terminated. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
    # @return [K8s::Model::Api::Core::V1::Handler,NilClass]
    attribute :preStop, K8s::Model::Api::Core::V1::Handler.optional.default(nil)

    register_paths [
      
    ]
  end
end
