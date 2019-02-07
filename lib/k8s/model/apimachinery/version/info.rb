# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/version"


module K8s::Model::Apimachinery::Version
  class Info < K8s::TypedResource
    # @return [K8s::API::Types::String]
    attribute :buildDate, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :compiler, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :gitCommit, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :gitTreeState, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :gitVersion, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :goVersion, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :major, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :minor, K8s::API::Types::String

    # @return [K8s::API::Types::String]
    attribute :platform, K8s::API::Types::String

    register_paths ["/version/"]
  end
end
