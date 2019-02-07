# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/coordination/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/micro_time'

module K8s::Model::Api::Coordination::V1beta1
  class LeaseSpec < K8s::TypedResource
    # acquireTime is a time when the current lease was acquired.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime,NilClass]
    attribute :acquireTime, K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime.optional.default(nil)

    # holderIdentity contains the identity of the holder of a current lease.
    # @return [K8s::API::Types::String,NilClass]
    attribute :holderIdentity, K8s::API::Types::String.optional.default(nil)

    # leaseDurationSeconds is a duration that candidates for a lease need to wait to force acquire it. This is measure against time of last observed RenewTime.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :leaseDurationSeconds, K8s::API::Types::Integer.optional.default(nil)

    # leaseTransitions is the number of transitions of a lease between holders.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :leaseTransitions, K8s::API::Types::Integer.optional.default(nil)

    # renewTime is a time when the current holder of a lease has last updated the lease.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime,NilClass]
    attribute :renewTime, K8s::Model::Apimachinery::Apis::Meta::V1::MicroTime.optional.default(nil)

    register_paths []
  end
end
