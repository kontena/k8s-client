require 'k8s/api'

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#TypeMeta
      class Resource < Struct
        # XXX: making these optional seems dangerous, but some APIs (GET /api/v1) are missing these
        attribute :kind, Types::Strict::String.optional.default(nil)
        attribute :apiVersion, Types::Strict::String.optional.default(nil)
      end
    end
  end
end

require 'k8s/api/metav1/api_group'
require 'k8s/api/metav1/api_resource'
require 'k8s/api/metav1/list'
require 'k8s/api/metav1/object'
require 'k8s/api/metav1/status'
