# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/api/resource/quantity'

module K8s::Model::Api::Core::V1
  class EmptyDirVolumeSource < K8s::TypedResource
    # What type of storage medium should back this directory. The default is "" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
    # @return [K8s::API::Types::String,NilClass]
    attribute :medium, K8s::API::Types::String.optional.default(nil)

    # Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir
    # @return [K8s::Model::Apimachinery::Api::Resource::Quantity,NilClass]
    attribute :sizeLimit, K8s::Model::Apimachinery::Api::Resource::Quantity.optional.default(nil)

    register_paths [
      
    ]
  end
end
