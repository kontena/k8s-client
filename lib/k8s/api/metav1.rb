# frozen_string_literal: true

require 'k8s/api'

module K8s
  module API
    # API types common to all apigroups/versions
    #
    # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1
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
require 'k8s/api/metav1/watch_event'
