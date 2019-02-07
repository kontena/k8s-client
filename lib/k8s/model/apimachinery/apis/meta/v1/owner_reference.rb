# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class OwnerReference < K8s::TypedResource
    # API version of the referent.
    # @return [K8s::API::Types::String]
    attribute :apiVersion, K8s::API::Types::String

    # If true, AND if the owner has the "foregroundDeletion" finalizer, then the owner cannot be deleted from the key-value store until this reference is removed. Defaults to false. To set this field, a user needs "delete" permission of the owner, otherwise 422 (Unprocessable Entity) will be returned.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :blockOwnerDeletion, K8s::API::Types::Bool.optional.default(nil)

    # If true, this reference points to the managing controller.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :controller, K8s::API::Types::Bool.optional.default(nil)

    # Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # Name of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#names
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # UID of the referent. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
    # @return [K8s::API::Types::String]
    attribute :uid, K8s::API::Types::String

    register_paths []
  end
end
