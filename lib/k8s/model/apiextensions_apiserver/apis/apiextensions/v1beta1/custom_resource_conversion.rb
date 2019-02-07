# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/webhook_client_config'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceConversion < K8s::TypedResource
    # `strategy` specifies the conversion strategy. Allowed values are: - `None`: The converter only change the apiVersion and would not touch any other field in the CR. - `Webhook`: API Server will call to an external webhook to do the conversion. Additional information is needed for this option.
    # @return [K8s::API::Types::String]
    attribute :strategy, K8s::API::Types::String

    # `webhookClientConfig` is the instructions for how to call the webhook if strategy is `Webhook`. This field is alpha-level and is only honored by servers that enable the CustomResourceWebhookConversion feature.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::WebhookClientConfig,NilClass]
    attribute :webhookClientConfig, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::WebhookClientConfig.optional.default(nil)

    register_paths []
  end
end
