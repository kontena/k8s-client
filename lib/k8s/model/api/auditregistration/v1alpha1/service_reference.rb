# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/auditregistration/v1alpha1"


module K8s::Model::Api::Auditregistration::V1alpha1
  class ServiceReference < K8s::TypedResource
    # `name` is the name of the service. Required
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # `namespace` is the namespace of the service. Required
    # @return [K8s::API::Types::String]
    attribute :namespace, K8s::API::Types::String

    # `path` is an optional URL path which will be sent in any request to this service.
    # @return [K8s::API::Types::String,NilClass]
    attribute :path, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
