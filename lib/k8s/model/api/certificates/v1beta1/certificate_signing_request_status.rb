# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/certificates/v1beta1"
require 'k8s/model/api/certificates/v1beta1/certificate_signing_request_condition'

module K8s::Model::Api::Certificates::V1beta1
  class CertificateSigningRequestStatus < K8s::TypedResource
    # If request was approved, the controller will place the issued certificate here.
    # @return [K8s::API::Types::String,NilClass]
    attribute :certificate, K8s::API::Types::String.optional.default(nil)

    # Conditions applied to the request, such as approval or denial.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Certificates::V1beta1::CertificateSigningRequestCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Certificates::V1beta1::CertificateSigningRequestCondition).optional.default(nil)

    register_paths [
      
    ]
  end
end
