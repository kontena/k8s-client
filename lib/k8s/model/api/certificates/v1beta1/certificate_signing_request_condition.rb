# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/certificates/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Certificates::V1beta1
  class CertificateSigningRequestCondition < K8s::TypedResource
    # timestamp for the last update to this condition
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :lastUpdateTime, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    # human readable message with details about the request state
    # @return [K8s::API::Types::String,NilClass]
    attribute :message, K8s::API::Types::String.optional.default(nil)

    # brief reason for the request state
    # @return [K8s::API::Types::String,NilClass]
    attribute :reason, K8s::API::Types::String.optional.default(nil)

    # request approval state, currently Approved or Denied.
    # @return [K8s::API::Types::String]
    attribute :type, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
