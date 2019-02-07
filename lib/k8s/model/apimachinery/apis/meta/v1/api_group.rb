# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/group_version_for_discovery'
require 'k8s/model/apimachinery/apis/meta/v1/server_address_by_client_cidr'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class APIGroup < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # name is the name of the group.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # preferredVersion is the version preferred by the API server, which probably is the storage version.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::GroupVersionForDiscovery,NilClass]
    attribute :preferredVersion, K8s::Model::Apimachinery::Apis::Meta::V1::GroupVersionForDiscovery.optional.default(nil)

    # a map of client CIDR to server address that is serving this group. This is to help clients reach servers in the most network-efficient way possible. Clients can use the appropriate server address as per the CIDR that they match. In case of multiple matches, clients should use the longest matching CIDR. The server returns only those CIDRs that it thinks that the client can match. For example: the master will return an internal IP CIDR only, if the client reaches the server using an internal IP. Server looks at X-Forwarded-For header or X-Real-Ip header or request.RemoteAddr (in that order) to get the client IP.
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::ServerAddressByClientCIDR),NilClass]
    attribute :serverAddressByClientCIDRs, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::ServerAddressByClientCIDR).optional.default(nil)

    # versions are the versions supported in this group.
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::GroupVersionForDiscovery)]
    attribute :versions, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::GroupVersionForDiscovery)

    register_paths ["/apis/admissionregistration.k8s.io/","/apis/apiextensions.k8s.io/","/apis/apiregistration.k8s.io/","/apis/apps/","/apis/auditregistration.k8s.io/","/apis/authentication.k8s.io/","/apis/authorization.k8s.io/","/apis/autoscaling/","/apis/batch/","/apis/certificates.k8s.io/","/apis/coordination.k8s.io/","/apis/events.k8s.io/","/apis/extensions/","/apis/networking.k8s.io/","/apis/policy/","/apis/rbac.authorization.k8s.io/","/apis/scheduling.k8s.io/","/apis/settings.k8s.io/","/apis/storage.k8s.io/"]
  end
end
