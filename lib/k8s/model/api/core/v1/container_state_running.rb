# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"
require 'k8s/model/apimachinery/apis/meta/v1/time'

module K8s::Model::Api::Core::V1
  class ContainerStateRunning < K8s::TypedResource
    # Time at which the container was last (re-)started
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::Time,NilClass]
    attribute :startedAt, K8s::Model::Apimachinery::Apis::Meta::V1::Time.optional.default(nil)

    register_paths []
  end
end
