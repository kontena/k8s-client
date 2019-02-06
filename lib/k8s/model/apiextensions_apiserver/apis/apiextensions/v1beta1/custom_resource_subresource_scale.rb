# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"


module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceSubresourceScale < K8s::TypedResource
    # LabelSelectorPath defines the JSON path inside of a CustomResource that corresponds to Scale.Status.Selector. Only JSON paths without the array notation are allowed. Must be a JSON Path under .status. Must be set to work with HPA. If there is no value under the given path in the CustomResource, the status label selector value in the /scale subresource will default to the empty string.
    # @return [K8s::API::Types::String,NilClass]
    attribute :labelSelectorPath, K8s::API::Types::String.optional.default(nil)

    # SpecReplicasPath defines the JSON path inside of a CustomResource that corresponds to Scale.Spec.Replicas. Only JSON paths without the array notation are allowed. Must be a JSON Path under .spec. If there is no value under the given path in the CustomResource, the /scale subresource will return an error on GET.
    # @return [K8s::API::Types::String]
    attribute :specReplicasPath, K8s::API::Types::String

    # StatusReplicasPath defines the JSON path inside of a CustomResource that corresponds to Scale.Status.Replicas. Only JSON paths without the array notation are allowed. Must be a JSON Path under .status. If there is no value under the given path in the CustomResource, the status replica value in the /scale subresource will default to 0.
    # @return [K8s::API::Types::String]
    attribute :statusReplicasPath, K8s::API::Types::String

    register_paths [
      
    ]
  end
end
