# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/api/core/v1/client_ip_config'

module K8s::Model::Api::Core::V1
  class SessionAffinityConfig < K8s::TypedResource
    # clientIP contains the configurations of Client IP based session affinity.
    # @return [K8s::Model::Api::Core::V1::ClientIPConfig,NilClass]
    attribute :clientIP, K8s::Model::Api::Core::V1::ClientIPConfig.optional.default(nil)

    register_paths [
      
    ]
  end
end
