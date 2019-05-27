# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # structured list of available APIGroup versions
      # groupVersion provided for convenience
      class APIGroupVersion < Struct
        attribute :groupVersion, K8s::Type::String
        attribute :version, K8s::Type::String
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIGroup
      class APIGroup < Struct
        attribute :name, K8s::Type::String
        attribute :versions, K8s::Type::Array.of(APIGroupVersion)
        attribute :preferredVersion, APIGroupVersion
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIGroupList
      class APIGroupList < Resource
        attribute :groups, K8s::Type::Array.of(APIGroup)
      end
    end
  end
end
