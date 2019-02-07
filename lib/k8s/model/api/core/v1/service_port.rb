# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/util/intstr/int_or_string'

module K8s::Model::Api::Core::V1
  class ServicePort < K8s::TypedResource
    # The name of this port within the service. This must be a DNS_LABEL. All ports within a ServiceSpec must have unique names. This maps to the 'Name' field in EndpointPort objects. Optional if only one ServicePort is defined on this service.
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # The port on each node on which this service is exposed when type=NodePort or LoadBalancer. Usually assigned by the system. If specified, it will be allocated to the service if unused or else creation of the service will fail. Default is to auto-allocate a port if the ServiceType of this Service requires one. More info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :nodePort, K8s::API::Types::Integer.optional.default(nil)

    # The port that will be exposed by this service.
    # @return [K8s::API::Types::Integer]
    attribute :port, K8s::API::Types::Integer

    # The IP protocol for this port. Supports "TCP", "UDP", and "SCTP". Default is TCP.
    # @return [K8s::API::Types::String,NilClass]
    attribute :protocol, K8s::API::Types::String.optional.default(nil)

    # Number or name of the port to access on the pods targeted by the service. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME. If this is a string, it will be looked up as a named port in the target Pod's container ports. If this is not specified, the value of the 'port' field is used (an identity map). This field is ignored for services with clusterIP=None, and should be omitted or set equal to the 'port' field. More info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString,NilClass]
    attribute :targetPort, K8s::Model::Apimachinery::Util::Intstr::IntOrString.optional.default(nil)

    register_paths []
  end
end
