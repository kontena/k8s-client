# frozen_string_literal: true

require 'k8s/api/metav1/status'

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#OwnerReference
      class OwnerReference < Resource
        attribute :name, K8s::Type::String
        attribute :uid, K8s::Type::String
        attribute :controller, K8s::Type::Bool
        attribute :blockOwnerDeletion, K8s::Type::Bool
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Initializer
      class Initializer < Struct
        attribute :name, K8s::Type::String
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Initializers
      class Initializers < Struct
        attribute :pending, Initializer
        attribute :result, Status
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#ObjectMeta
      class ObjectMeta < Resource
        attribute :name, K8s::Type::String
        attribute :generateName, K8s::Type::String
        attribute :namespace, K8s::Type::String
        attribute :selfLink, K8s::Type::String
        attribute :uid, K8s::Type::String
        attribute :resourceVersion, K8s::Type::String
        attribute :generation, K8s::Type::Integer
        attribute :creationTimestamp, K8s::Type::DateTime
        attribute :deletionTimestamp, K8s::Type::DateTime
        attribute :deletionGracePeriodSeconds, K8s::Type::Integer
        attribute :labels, K8s::Type::Hash
        attribute :annotations, K8s::Type::Hash
        attribute :ownerReferences, K8s::Type::Array.of(OwnerReference)
        attribute :initializers, Initializers
        attribute :finalizers, K8s::Type::Array
        attribute :clusterName, K8s::Type::String
      end

      # common attributes shared by all object types
      class ObjectCommon < Resource
        attribute :metadata, ObjectMeta
      end
    end
  end
end
