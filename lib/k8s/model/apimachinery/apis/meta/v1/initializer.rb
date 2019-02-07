# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class Initializer < K8s::TypedResource
    # name of the process that is responsible for initializing this object.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    register_paths []
  end
end
