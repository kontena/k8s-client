# frozen_string_literal: true

require_relative 'resource'

module K8s
  class WatchEvent < Resource
    # @return [K8s::Resource] the resource the `object` in the WatchEvent refers to
    def resource
      @resource ||= Resource.new(object)
    end
  end
end
