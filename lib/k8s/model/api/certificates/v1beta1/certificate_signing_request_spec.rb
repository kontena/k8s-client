# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/certificates/v1beta1"


module K8s::Model::Api::Certificates::V1beta1
  class CertificateSigningRequestSpec < K8s::TypedResource
    # Extra information about the requesting user. See user.Info interface for details.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :extra, K8s::API::Types::Hash.optional.default(nil)

    # Group information about the requesting user. See user.Info interface for details.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :groups, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Base64-encoded PKCS#10 CSR data
    # @return [K8s::API::Types::String]
    attribute :request, K8s::API::Types::String

    # UID information about the requesting user. See user.Info interface for details.
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    # allowedUsages specifies a set of usage contexts the key will be valid for. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3

    #      https://tools.ietf.org/html/rfc5280#section-4.2.1.12
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String),NilClass]
    attribute :usages, K8s::API::Types::Array.of(K8s::API::Types::String).optional.default(nil)

    # Information about the requesting user. See user.Info interface for details.
    # @return [K8s::API::Types::String,NilClass]
    attribute :username, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
