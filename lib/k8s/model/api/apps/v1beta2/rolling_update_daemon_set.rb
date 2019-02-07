# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/apps/v1beta2"
require 'k8s/model/apimachinery/util/intstr/int_or_string'

module K8s::Model::Api::Apps::V1beta2
  class RollingUpdateDaemonSet < K8s::TypedResource
    # The maximum number of DaemonSet pods that can be unavailable during the update. Value can be an absolute number (ex: 5) or a percentage of total number of DaemonSet pods at the start of the update (ex: 10%). Absolute number is calculated from percentage by rounding up. This cannot be 0. Default value is 1. Example: when this is set to 30%, at most 30% of the total number of nodes that should be running the daemon pod (i.e. status.desiredNumberScheduled) can have their pods stopped for an update at any given time. The update starts by stopping at most 30% of those DaemonSet pods and then brings up new DaemonSet pods in their place. Once the new pods are available, it then proceeds onto other DaemonSet pods, thus ensuring that at least 70% of original number of DaemonSet pods are available at all times during the update.
    # @return [K8s::Model::Apimachinery::Util::Intstr::IntOrString,NilClass]
    attribute :maxUnavailable, K8s::Model::Apimachinery::Util::Intstr::IntOrString.optional.default(nil)

    register_paths []
  end
end
