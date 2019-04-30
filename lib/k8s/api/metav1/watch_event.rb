# frozen_string_literal: true

require_relative '../../resource'

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#WatchEvent
      class WatchEvent < Resource
        attribute :type, Types::Strict::String
        attribute :object, Types::Strict::Hash

        # @return [K8s::Resource]
        def resource
          @resource ||= K8s::Resource.new(object)
        end
      end
    end
  end
end
