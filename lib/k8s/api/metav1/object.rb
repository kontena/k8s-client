# frozen_string_literal: true

require 'k8s/api/metav1/status'

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#OwnerReference
      class OwnerReference < Resource
        attribute :name, Types::String
        attribute :uid, Types::String
        attribute :controller, Types::Bool.optional.default(nil)
        attribute :blockOwnerDeletion, Types::Bool.optional.default(nil)
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Initializer
      class Initializer < Struct
        attribute :name, Types::String
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Initializers
      class Initializers < Struct
        attribute :pending, Initializer
        attribute :result, Status.optional.default(nil)
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#ObjectMeta
      class ObjectMeta < Resource
        attribute :name, Types::String.optional.default(nil)
        attribute :generateName, Types::String.optional.default(nil)
        attribute :namespace, Types::String.optional.default(nil)
        attribute :selfLink, Types::String.optional.default(nil)
        attribute :uid, Types::String.optional.default(nil)
        attribute :resourceVersion, Types::String.optional.default(nil)
        attribute :generation, Types::Integer.optional.default(nil)
        attribute :creationTimestamp, Types::DateTime.optional.default(nil)
        attribute :deletionTimestamp, Types::DateTime.optional.default(nil)
        attribute :deletionGracePeriodSeconds, Types::Integer.optional.default(nil)
        attribute :labels, Types::Hash.map(Types::Strict::String, Types::Strict::String).optional.default(nil)
        attribute :annotations, Types::Hash.map(Types::Strict::String, Types::Strict::String).optional.default(nil)
        attribute(:ownerReferences, Types::Array.of(OwnerReference).optional.default { [] })
        attribute :initializers, Initializers.optional.default(nil)
        attribute(:finalizers, Types::Array.of(Types::Strict::String).optional.default { [] })
        attribute :clusterName, Types::String.optional.default(nil)
      end

      # common attributes shared by all object types
      class ObjectCommon < Resource
        attribute :metadata, ObjectMeta.optional.default(nil)
      end
    end
  end
end
