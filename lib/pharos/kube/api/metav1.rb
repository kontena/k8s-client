require 'pharos/kube/api'

module Pharos
  module Kube
    module API
      module MetaV1
        class Resource < Struct
          # XXX: making these optional seems dangerous, but some APIs (GET /api/v1) are missing these
          attribute :kind, Types::Strict::String.optional.default(nil)
          attribute :apiVersion, Types::Strict::String.optional.default(nil)
        end
      end
    end
  end
end

require 'pharos/kube/api/metav1/api_resource'
