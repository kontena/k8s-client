# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/runtime"


module K8s::Model::Apimachinery::Runtime
  class RawExtension < K8s::TypedResource
    # Raw is the underlying serialization of this object.
    # @return [K8s::API::Types::String]
    attribute :Raw, K8s::API::Types::String

    register_paths []
  end
end
