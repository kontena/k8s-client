# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/networking/v1"
require 'k8s/model/apimachinery/util/intstr/int_or_string'

module K8s::Model::Api::Networking::V1
  class NetworkPolicyPort < K8s::TypedResource
    # The port on the given protocol. This can either be a numerical or named port on a pod. If this field is not provided, this matches all port names and numbers.
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString,NilClass]
    attribute :port, K8s::Model::Apimachinery::Util::Intstr::IntOrString.optional.default(nil)

    # The protocol (TCP, UDP, or SCTP) which traffic must match. If not specified, this field defaults to TCP.
    # @return [K8s::API::Types::String,NilClass]
    attribute :protocol, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
