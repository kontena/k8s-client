require 'pharos/kube/api/metav1/status'

module Pharos
  module Kube
    module API
      module MetaV1
        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#OwnerReference
        class OwnerReference < Resource
          attribute :name, Types::Strict::String
          attribute :uid, Types::Strict::String
          attribute :controller, Types::Strict::Bool.optional.default(nil)
          attribute :blockOwnerDeletion, Types::Strict::Bool.optional.default(nil)
        end

        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Initializer
        class Initializer < Struct
          attribute :name, Types::Strict::String
        end

        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Initializers
        class Initializers < Struct
          attribute :pending, Initializer
          attribute :result, Status.optional.default(nil)
        end

        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#ObjectMeta
        class ObjectMeta < Resource
          attribute :name, Types::Strict::String.optional.default(nil)
          attribute :generateName, Types::Strict::String.optional.default(nil)
          attribute :namespace, Types::Strict::String.optional.default(nil)
          attribute :selfLink, Types::Strict::String.optional.default(nil)
          attribute :uid, Types::Strict::String.optional.default(nil)
          attribute :resourceVersion, Types::Strict::String.optional.default(nil)
          attribute :generation, Types::Strict::Integer.optional.default(nil)
          attribute :creationTimestamp, Types::DateTime.optional.default(nil)
          attribute :deletionTimestamp, Types::DateTime.optional.default(nil)
          attribute :deletionGracePeriodSeconds, Types::Strict::Integer.optional.default(nil)
          attribute :labels, Types::Strict::Hash.map(Types::Strict::String, Types::Strict::String).optional.default(nil)
          attribute :annotations, Types::Strict::Hash.map(Types::Strict::String, Types::Strict::String).optional.default(nil)
          attribute :ownerReferences, Types::Strict::Array.of(OwnerReference).optional.default([])
          attribute :initializers, Initializers.optional.default(nil)
          attribute :finalizers, Types::Strict::Array.of(Types::Strict::String).optional.default([])
          attribute :clusterName, Types::Strict::String.optional.default(nil)
        end

        # common attributes shared by all object types
        class ObjectCommon < Resource
          attribute :metadata, ObjectMeta.optional.default(nil)
        end
      end
    end
  end
end
