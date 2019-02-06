# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class ClientIPConfig < K8s::TypedResource
    # timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == "ClientIP". Default value is 10800(for 3 hours).
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :timeoutSeconds, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
