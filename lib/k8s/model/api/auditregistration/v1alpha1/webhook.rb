# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/auditregistration/v1alpha1"
require 'k8s/model/api/auditregistration/v1alpha1/webhook_client_config'
require 'k8s/model/api/auditregistration/v1alpha1/webhook_throttle_config'

module K8s::Model::Api::Auditregistration::V1alpha1
  class Webhook < K8s::TypedResource
    # ClientConfig holds the connection parameters for the webhook required
    # @return [K8s::Model::Api::Auditregistration::V1alpha1::WebhookClientConfig]
    attribute :clientConfig, K8s::Model::Api::Auditregistration::V1alpha1::WebhookClientConfig

    # Throttle holds the options for throttling the webhook
    # @return [K8s::Model::Api::Auditregistration::V1alpha1::WebhookThrottleConfig,NilClass]
    attribute :throttle, K8s::Model::Api::Auditregistration::V1alpha1::WebhookThrottleConfig.optional.default(nil)

    register_paths [
      
    ]
  end
end
