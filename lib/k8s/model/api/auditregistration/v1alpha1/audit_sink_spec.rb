# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/auditregistration/v1alpha1"
require 'k8s/model/api/auditregistration/v1alpha1/policy'
require 'k8s/model/api/auditregistration/v1alpha1/webhook'

module K8s::Model::Api::Auditregistration::V1alpha1
  class AuditSinkSpec < K8s::TypedResource
    # Policy defines the policy for selecting which events should be sent to the webhook required
    # @return [K8s::Model::Api::Auditregistration::V1alpha1::Policy]
    attribute :policy, K8s::Model::Api::Auditregistration::V1alpha1::Policy

    # Webhook to send events required
    # @return [K8s::Model::Api::Auditregistration::V1alpha1::Webhook]
    attribute :webhook, K8s::Model::Api::Auditregistration::V1alpha1::Webhook

    register_paths []
  end
end
