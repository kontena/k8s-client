# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"


module K8s::Model::Api::Extensions::V1beta1
  class IPBlock < K8s::TypedResource
    # CIDR is a string representing the IP Block Valid examples are "192.168.1.1/24"
    # @return [K8s::API::Types::String]
    attribute :cidr, K8s::API::Types::String

    # Except is a slice of CIDRs that should not be included within an IP Block Valid examples are "192.168.1.1/24" Except values will be rejected if they are outside the CIDR range
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :except, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    register_paths [
      
    ]
  end
end
