module Pharos
  module Kube
    module API
      module MetaV1
        class APIResource < Struct
          attribute :name, Types::Strict::String
          attribute :singularName, Types::Strict::String
          attribute :namespaced, Types::Strict::Bool
          attribute :group, Types::Strict::String.optional.default(nil)
          attribute :version, Types::Strict::String.optional.default(nil)
          attribute :kind, Types::Strict::String
          attribute :verbs, Types::Strict::Array.of(Types::Strict::String)
          attribute :shortNames, Types::Strict::Array.of(Types::Strict::String).optional.default([])
          attribute :categories, Types::Strict::Array.of(Types::Strict::String).optional.default([])
        end

        class APIResourceList < Resource
          attribute :groupVersion, Types::Strict::String
          attribute :resources, Types::Strict::Array.of(APIResource)
        end
      end
    end
  end
end
