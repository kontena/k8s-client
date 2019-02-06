# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/rbac/v1beta1"


module K8s::Model::Api::Rbac::V1beta1
  class Subject < K8s::TypedResource
    # APIGroup holds the API group of the referenced subject. Defaults to "" for ServiceAccount subjects. Defaults to "rbac.authorization.k8s.io" for User and Group subjects.
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiGroup, K8s::API::Types::String.optional.default(nil)

    # Kind of object being referenced. Values defined by this API group are "User", "Group", and "ServiceAccount". If the Authorizer does not recognized the kind value, the Authorizer should report an error.
    # @return [K8s::API::Types::String]
    attribute :kind, K8s::API::Types::String

    # Name of the object being referenced.
    # @return [K8s::API::Types::String]
    attribute :name, K8s::API::Types::String

    # Namespace of the referenced object.  If the object kind is non-namespace, such as "User" or "Group", and this value is not empty the Authorizer should report an error.
    # @return [K8s::API::Types::String,NilClass]
    attribute :namespace, K8s::API::Types::String.optional.default(nil)

    register_paths [
      
    ]
  end
end
