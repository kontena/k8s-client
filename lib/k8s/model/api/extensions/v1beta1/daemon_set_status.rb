# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/extensions/v1beta1"
require 'k8s/model/api/extensions/v1beta1/daemon_set_condition'

module K8s::Model::Api::Extensions::V1beta1
  class DaemonSetStatus < K8s::TypedResource
    # Count of hash collisions for the DaemonSet. The DaemonSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :collisionCount, K8s::API::Types::Integer.optional.default(nil)

    # Represents the latest available observations of a DaemonSet's current state.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::DaemonSetCondition),NilClass]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::Api::Extensions::V1beta1::DaemonSetCondition).optional.default(nil)

    # The number of nodes that are running at least 1 daemon pod and are supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    # @return [K8s::API::Types::Integer]
    attribute :currentNumberScheduled, K8s::API::Types::Integer

    # The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod). More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    # @return [K8s::API::Types::Integer]
    attribute :desiredNumberScheduled, K8s::API::Types::Integer

    # The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds)
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :numberAvailable, K8s::API::Types::Integer.optional.default(nil)

    # The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/
    # @return [K8s::API::Types::Integer]
    attribute :numberMisscheduled, K8s::API::Types::Integer

    # The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.
    # @return [K8s::API::Types::Integer]
    attribute :numberReady, K8s::API::Types::Integer

    # The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds)
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :numberUnavailable, K8s::API::Types::Integer.optional.default(nil)

    # The most recent generation observed by the daemon set controller.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :observedGeneration, K8s::API::Types::Integer.optional.default(nil)

    # The total number of nodes that are running updated daemon pod
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :updatedNumberScheduled, K8s::API::Types::Integer.optional.default(nil)

    register_paths []
  end
end
