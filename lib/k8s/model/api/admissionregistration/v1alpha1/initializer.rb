# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/admissionregistration/v1alpha1"
require 'k8s/model/api/admissionregistration/v1alpha1/rule'

module K8s::Model::Api::Admissionregistration::V1alpha1
  class Initializer < K8s::TypedResource
    # Name is the identifier of the initializer. It will be added to the object that needs to be initialized. Name should be fully qualified, e.g., alwayspullimages.kubernetes.io, where "alwayspullimages" is the name of the webhook, and kubernetes.io is the name of the organization. Required
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Rules describes what resources/subresources the initializer cares about. The initializer cares about an operation if it matches _any_ Rule. Rule.Resources must not include subresources.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Admissionregistration::V1alpha1::Rule),NilClass]
    attribute :rules, K8s::API::Types::Array.of(K8s::Model::Api::Admissionregistration::V1alpha1::Rule).optional.default(nil)

    register_paths [
      
    ]
  end
end
