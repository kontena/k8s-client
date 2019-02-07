# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/policy/v1beta1"


module K8s::Model::Api::Policy::V1beta1
  class AllowedHostPath < K8s::TypedResource
    # pathPrefix is the path prefix that the host volume must match. It does not support `*`. Trailing slashes are trimmed when validating the path prefix with a host path.

    # Examples: `/foo` would allow `/foo`, `/foo/` and `/foo/bar` `/foo` would not allow `/food` or `/etc/foo`
    # @return [K8s::API::Types::String,NilClass]
    attribute :pathPrefix, K8s::API::Types::String.optional.default(nil)

    # when set to true, will allow host volumes matching the pathPrefix only if all volume mounts are readOnly.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :readOnly, K8s::API::Types::Bool.optional.default(nil)

    register_paths []
  end
end
