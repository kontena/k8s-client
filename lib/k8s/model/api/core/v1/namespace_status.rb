# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class NamespaceStatus < K8s::TypedResource
    # Phase is the current lifecycle phase of the namespace. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/
    # @return [K8s::API::Types::String,NilClass]
    attribute :phase, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
