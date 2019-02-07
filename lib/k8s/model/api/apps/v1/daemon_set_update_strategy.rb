# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1"
require 'k8s/model/api/apps/v1/rolling_update_daemon_set'

module K8s::Model::Api::Apps::V1
  class DaemonSetUpdateStrategy < K8s::TypedResource
    # Rolling update config params. Present only if type = "RollingUpdate".
    # @return [K8s::Model::Api::Apps::V1::RollingUpdateDaemonSet,NilClass]
    attribute :rollingUpdate, K8s::Model::Api::Apps::V1::RollingUpdateDaemonSet.optional.default(nil)

    # Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.
    # @return [K8s::API::Types::String,NilClass]
    attribute :type, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
