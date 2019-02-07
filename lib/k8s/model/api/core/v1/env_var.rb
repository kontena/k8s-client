# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/env_var_source'

module K8s::Model::Api::Core::V1
  class EnvVar < K8s::TypedResource
    # Name of the environment variable. Must be a C_IDENTIFIER.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to "".
    # @return [K8s::API::Types::String,NilClass]
    attribute :value, K8s::API::Types::String.optional.default(nil)

    # Source for the environment variable's value. Cannot be used if value is not empty.
    # @return [K8s::Model::Api::Core::V1::EnvVarSource,NilClass]
    attribute :valueFrom, K8s::Model::Api::Core::V1::EnvVarSource.optional.default(nil)

    register_paths []
  end
end
