# frozen_string_literal: true

require_relative 'resource'

module K8s
  class WatchEvent < Resource
    def resource
      @resource ||= Resource.new(object)
    end
  end
end
