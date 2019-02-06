# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/limit_range_item'

module K8s::Model::Api::Core::V1
  class LimitRangeSpec < K8s::TypedResource
    # Limits is the list of LimitRangeItem objects that are enforced.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::LimitRangeItem)]
    attribute :limits, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::LimitRangeItem)

    register_paths [
      
    ]
  end
end
