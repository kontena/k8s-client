# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/apimachinery/util/intstr/int_or_string'

module K8s::Model::Api::Extensions::V1beta1
  class IngressBackend < K8s::TypedResource
    # Specifies the name of the referenced service.
    # @return [K8s::API::Types::String]
    attribute :serviceName, K8s::API::Types::String

    # Specifies the port of the referenced service.
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString]
    attribute :servicePort, K8s::Model::Apimachinery::Util::Intstr::IntOrString

    register_paths []
  end
end
