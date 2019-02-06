# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class Preconditions < K8s::TypedResource
    # Specifies the target UID.
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
