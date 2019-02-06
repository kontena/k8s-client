# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/initializer'
require 'k8s/model/apimachinery/apis/meta/v1/status'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class Initializers < K8s::TypedResource
    # Pending is a list of initializers that must execute in order before this object is visible. When the last pending initializer is removed, and no failing result is set, the initializers struct will be set to nil and the object is considered as initialized and visible to all clients.
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::Initializer)]
    attribute :pending, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::Initializer)

    # If result is set with the Failure field, the object will be persisted to storage and then deleted, ensuring that other clients can observe the deletion.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Status,NilClass]
    attribute :result, K8s::Model::Apimachinery::Apis::Meta::V1::Status.optional.default(nil)

    register_paths [
      
    ]
  end
end
