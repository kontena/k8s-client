# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class GroupVersionForDiscovery < K8s::TypedResource
    # groupVersion specifies the API group and version in the form "group/version"
    # @return [K8s::API::Types::String]
    attribute :groupVersion, K8s::API::Types::String

    # version specifies the version in the form of "version". This is to save the clients the trouble of splitting the GroupVersion.
    # @return [K8s::API::Types::String]
    attribute :version, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
