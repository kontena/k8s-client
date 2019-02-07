# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/certificates/v1beta1"
require 'k8s/model/apimachinery/apis/meta/v1/object_meta'
require 'k8s/model/api/certificates/v1beta1/certificate_signing_request_spec'
require 'k8s/model/api/certificates/v1beta1/certificate_signing_request_status'

module K8s::Model::Api::Certificates::V1beta1
  class CertificateSigningRequest < K8s::TypedResource
    # APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta,NilClass]
    attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ObjectMeta.optional.default(nil)

    # The certificate request itself and any additional information.
    # @return [K8s::Model::Api::Certificates::V1beta1::CertificateSigningRequestSpec,NilClass]
    attribute :spec, K8s::Model::Api::Certificates::V1beta1::CertificateSigningRequestSpec.optional.default(nil)

    # Derived information about the request.
    # @return [K8s::Model::Api::Certificates::V1beta1::CertificateSigningRequestStatus,NilClass]
    attribute :status, K8s::Model::Api::Certificates::V1beta1::CertificateSigningRequestStatus.optional.default(nil)

    register_paths ["/apis/certificates.k8s.io/v1beta1/certificatesigningrequests/{name}","/apis/certificates.k8s.io/v1beta1/certificatesigningrequests/{name}/status"]
  end
end
