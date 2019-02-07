# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ObjectReference < K8s::TypedResource
    # API version of the referent.
    # @return [K8s::API::Types::String,NilClass]
    attribute :apiVersion, K8s::API::Types::String.optional.default(nil)

    # If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: "spec.containers{name}" (where "name" refers to the name of the container that triggered the event) or if no container name is specified "spec.containers[2]" (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object.
    # @return [K8s::API::Types::String,NilClass]
    attribute :fieldPath, K8s::API::Types::String.optional.default(nil)

    # Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds
    # @return [K8s::API::Types::String,NilClass]
    attribute :kind, K8s::API::Types::String.optional.default(nil)

    # Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
    # @return [K8s::API::Types::String,NilClass]
    attribute :name, K8s::API::Types::String.optional.default(nil)

    # Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
    # @return [K8s::API::Types::String,NilClass]
    attribute :namespace, K8s::API::Types::String.optional.default(nil)

    # Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
    # @return [K8s::API::Types::String,NilClass]
    attribute :resourceVersion, K8s::API::Types::String.optional.default(nil)

    # UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
    # @return [K8s::API::Types::String,NilClass]
    attribute :uid, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
