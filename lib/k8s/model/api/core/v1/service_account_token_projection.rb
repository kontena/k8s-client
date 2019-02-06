# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ServiceAccountTokenProjection < K8s::TypedResource
    # Audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver.
    # @return [K8s::API::Types::String,NilClass]
    attribute :audience, K8s::API::Types::String.optional.default(nil)

    # ExpirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :expirationSeconds, K8s::API::Types::Integer.optional.default(nil)

    # Path is the path relative to the mount point of the file to project the token into.
    # @return [K8s::API::Types::String]
    attribute :path, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
