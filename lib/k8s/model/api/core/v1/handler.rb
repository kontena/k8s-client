# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/exec_action'
require 'k8s/model/api/core/v1/http_get_action'
require 'k8s/model/api/core/v1/tcp_socket_action'

module K8s::Model::Api::Core::V1
  class Handler < K8s::TypedResource
    # One and only one of the following should be specified. Exec specifies the action to take.
    # @return [K8s::Model::Api::Core::V1::ExecAction,NilClass]
    attribute :exec, K8s::Model::Api::Core::V1::ExecAction.optional.default(nil)

    # HTTPGet specifies the http request to perform.
    # @return [K8s::Model::Api::Core::V1::HTTPGetAction,NilClass]
    attribute :httpGet, K8s::Model::Api::Core::V1::HTTPGetAction.optional.default(nil)

    # TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported
    # @return [K8s::Model::Api::Core::V1::TCPSocketAction,NilClass]
    attribute :tcpSocket, K8s::Model::Api::Core::V1::TCPSocketAction.optional.default(nil)

    register_paths []
  end
end
