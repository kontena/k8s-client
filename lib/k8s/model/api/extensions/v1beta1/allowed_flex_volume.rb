# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"


module K8s::Model::Api::Extensions::V1beta1
  class AllowedFlexVolume < K8s::TypedResource
    # driver is the name of the Flexvolume driver.
    # @return [K8s::API::Types::String]
    attribute :driver, K8s::API::Types::String

    register_paths []
  end
end
