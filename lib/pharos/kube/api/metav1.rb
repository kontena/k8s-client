require 'pharos/kube/api'

module Pharos
  module Kube
    module API
      module MetaV1
        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#TypeMeta
        class Resource < Struct
          # @param data [Hash]
          # @return [self]
          def self.from_json(data)
            return new(**data)
          end

          # XXX: making these optional seems dangerous, but some APIs (GET /api/v1) are missing these
          attribute :kind, Types::Strict::String.optional.default(nil)
          attribute :apiVersion, Types::Strict::String.optional.default(nil)

          # @return [String]
          def to_json
            to_hash.to_json
          end
        end
      end
    end
  end
end

require 'pharos/kube/api/metav1/api_group'
require 'pharos/kube/api/metav1/api_resource'
require 'pharos/kube/api/metav1/list'
require 'pharos/kube/api/metav1/object'
require 'pharos/kube/api/metav1/status'
