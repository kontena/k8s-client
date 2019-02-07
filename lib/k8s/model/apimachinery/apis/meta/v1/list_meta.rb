# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apimachinery/apis/meta/v1"


module K8s::Model::Apimachinery::Apis::Meta::V1
  class ListMeta < K8s::TypedResource
    # continue may be set if the user set a limit on the number of items returned, and indicates that the server has more data available. The value is opaque and may be used to issue another request to the endpoint that served this list to retrieve the next set of available objects. Continuing a consistent list may not be possible if the server configuration has changed or more than a few minutes have passed. The resourceVersion field returned when using this continue value will be identical to the value in the first response, unless you have received this token from an error message.
    # @return [K8s::API::Types::String,NilClass]
    attribute :continue, K8s::API::Types::String.optional.default(nil)

    # String that identifies the server's internal version of this object that can be used by clients to determine when objects have changed. Value must be treated as opaque by clients and passed unmodified back to the server. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
    # @return [K8s::API::Types::String,NilClass]
    attribute :resourceVersion, K8s::API::Types::String.optional.default(nil)

    # selfLink is a URL representing this object. Populated by the system. Read-only.
    # @return [K8s::API::Types::String,NilClass]
    attribute :selfLink, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
