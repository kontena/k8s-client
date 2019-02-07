# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1"
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_definition_names'
require 'k8s/model/apiextensions_apiserver/apis/apiextensions/v1beta1/custom_resource_definition_condition'

module K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1
  class CustomResourceDefinitionStatus < K8s::TypedResource
    # AcceptedNames are the names that are actually being used to serve discovery They may be different than the names in spec.
    # @return [K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionNames]
    attribute :acceptedNames, K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionNames

    # Conditions indicate state for particular aspects of a CustomResourceDefinition
    # @return [K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionCondition)]
    attribute :conditions, K8s::API::Types::Array.of(K8s::Model::ApiextensionsApiserver::Apis::Apiextensions::V1beta1::CustomResourceDefinitionCondition)

    # StoredVersions are all versions of CustomResources that were ever persisted. Tracking these versions allows a migration path for stored versions in etcd. The field is mutable so the migration controller can first finish a migration to another version (i.e. that no old objects are left in the storage), and then remove the rest of the versions from this list. None of the versions in this list can be removed from the spec.Versions field.
    # @return [K8s::API::Types::Array.of(K8s::API::Types::String)]
    attribute :storedVersions, K8s::API::Types::Array.of(K8s::API::Types::String)

    register_paths []
  end
end
