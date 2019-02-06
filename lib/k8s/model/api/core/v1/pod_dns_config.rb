# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/pod_dns_config_option'

module K8s::Model::Api::Core::V1
  class PodDNSConfig < K8s::TypedResource
    # A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :nameservers, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PodDNSConfigOption),NilClass]
    attribute :options, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::PodDNSConfigOption).optional.default(nil)

    # A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :searches, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths [
      
    ]
  end
end
