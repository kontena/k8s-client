# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # structured list of available APIGroup versions
      # groupVersion provided for convenience
      class APIGroupVersion < Struct
        attribute :groupVersion, Types::Strict::String
        attribute :version, Types::Strict::String
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIGroup
      class APIGroup < Struct
        attribute :name, Types::Strict::String
        attribute :versions, Types::Strict::Array.of(APIGroupVersion)
        attribute :preferredVersion, APIGroupVersion
      end

      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIGroupList
      class APIGroupList < Resource
        attribute :groups, Types::Strict::Array.of(APIGroup)
      end
    end
  end
end
