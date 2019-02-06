# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"


module K8s::Model::Api::Extensions::V1beta1
  class RollbackConfig < K8s::TypedResource
    # The revision to rollback to. If set to 0, rollback to the last revision.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :revision, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
