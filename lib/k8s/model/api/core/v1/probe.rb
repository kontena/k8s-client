# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/exec_action'
require 'k8s/model/api/core/v1/http_get_action'
require 'k8s/model/api/core/v1/tcp_socket_action'

module K8s::Model::Api::Core::V1
  class Probe < K8s::TypedResource
    # One and only one of the following should be specified. Exec specifies the action to take.
    # @return [K8s::Model::Api::Core::V1::ExecAction,NilClass]
    attribute :exec, K8s::Model::Api::Core::V1::ExecAction.optional.default(nil)

    # Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :failureThreshold, K8s::API::Types::Integer.optional.default(nil)

    # HTTPGet specifies the http request to perform.
    # @return [K8s::Model::Api::Core::V1::HTTPGetAction,NilClass]
    attribute :httpGet, K8s::Model::Api::Core::V1::HTTPGetAction.optional.default(nil)

    # Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :initialDelaySeconds, K8s::API::Types::Integer.optional.default(nil)

    # How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :periodSeconds, K8s::API::Types::Integer.optional.default(nil)

    # Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness. Minimum value is 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :successThreshold, K8s::API::Types::Integer.optional.default(nil)

    # TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported
    # @return [K8s::Model::Api::Core::V1::TCPSocketAction,NilClass]
    attribute :tcpSocket, K8s::Model::Api::Core::V1::TCPSocketAction.optional.default(nil)

    # Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :timeoutSeconds, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
