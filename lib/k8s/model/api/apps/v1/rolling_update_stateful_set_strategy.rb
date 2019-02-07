# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1"


module K8s::Model::Api::Apps::V1
  class RollingUpdateStatefulSetStrategy < K8s::TypedResource
    # Partition indicates the ordinal at which the StatefulSet should be partitioned. Default value is 0.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :partition, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
