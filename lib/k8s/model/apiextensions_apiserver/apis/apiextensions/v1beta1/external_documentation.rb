# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"


module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class ExternalDocumentation < K8s::TypedResource
    # @return [K8s::API::Types::String,NilClass]
    attribute :description, K8s::API::Types::String.optional.default(nil)

    # @return [K8s::API::Types::String,NilClass]
    attribute :url, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
