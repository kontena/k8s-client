# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector_requirement'

module K8s::Model::Apimachinery::Apis::Meta::V1
  class LabelSelector < K8s::TypedResource
    # matchExpressions is a list of label selector requirements. The requirements are ANDed.
    # @return [K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelectorRequirement),NilClass]
    attribute :matchExpressions, K8s::API::Types::Array.of(K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelectorRequirement).optional.default(nil)

    # matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.
    # @return [K8s::API::Types::Hash,NilClass]
    attribute :matchLabels, K8s::API::Types::Hash.optional.default(nil)

    register_paths []
  end
end
