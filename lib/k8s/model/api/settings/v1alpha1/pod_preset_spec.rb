# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/settings/v1alpha1"
require 'k8s/model/api/core/v1/env_var'
require 'k8s/model/api/core/v1/env_from_source'
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/core/v1/volume_mount'
require 'k8s/model/api/core/v1/volume'

module K8s::Model::Api::Settings::V1alpha1
  class PodPresetSpec < K8s::TypedResource
    # Env defines the collection of EnvVar to inject into containers.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvVar),NilClass]
    attribute :env, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvVar).optional.default(nil)

    # EnvFrom defines the collection of EnvFromSource to inject into containers.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvFromSource),NilClass]
    attribute :envFrom, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::EnvFromSource).optional.default(nil)

    # Selector is a label query over a set of resources, in this case pods. Required.
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # VolumeMounts defines the collection of VolumeMount to inject into containers.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeMount),NilClass]
    attribute :volumeMounts, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::VolumeMount).optional.default(nil)

    # Volumes defines the collection of Volume to inject into the pod.
    # @return [K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Volume),NilClass]
    attribute :volumes, K8s::API::Types::Array.of(K8s::Model::Api::Core::V1::Volume).optional.default(nil)

    register_paths [
      
    ]
  end
end
