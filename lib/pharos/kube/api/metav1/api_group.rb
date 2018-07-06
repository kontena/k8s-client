module Pharos
  module Kube
    module API
      module MetaV1
        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIGroup
        class APIGroup < Struct
          attribute :name, Types::Strict::String
          attribute :versions, Types::Strict::Array do
            attribute :groupVersion, Types::Strict::String
            attribute :version, Types::Strict::String
          end
          attribute :preferredVersion do
            attribute :groupVersion, Types::Strict::String
            attribute :version, Types::Strict::String
          end
        end

        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#APIGroupList
        class APIGroupList < Resource
          attribute :groups, Types::Strict::Array.of(APIGroup)
        end
      end
    end
  end
end
