# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/auditregistration/v1alpha1"


module K8s::Model::Api::Auditregistration::V1alpha1
  class WebhookThrottleConfig < K8s::TypedResource
    # ThrottleBurst is the maximum number of events sent at the same moment default 15 QPS
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :burst, K8s::API::Types::Integer.optional.default(nil)

    # ThrottleQPS maximum number of batches per second default 10 QPS
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :qps, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
