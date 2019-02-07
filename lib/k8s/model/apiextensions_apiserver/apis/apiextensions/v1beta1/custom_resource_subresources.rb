# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_subresource_scale'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_subresource_status'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceSubresources < K8s::TypedResource
    # Scale denotes the scale subresource for CustomResources
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresourceScale,NilClass]
    attribute :scale, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresourceScale.optional.default(nil)

    # Status denotes the status subresource for CustomResources
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresourceStatus,NilClass]
    attribute :status, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceSubresourceStatus.optional.default(nil)

    register_paths []
  end
end
