# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require 'k8s/resource'
require 'k8s/typed_resource'

module K8s
  # Kube API definitions
  module API
    # Common Dry::Types used in the API
    module Types
      include Dry::Types.module
    end

    # Common API struct type, handling JSON transforms with symbol keys
    class Struct < Dry::Struct
      # input from JSON with string keys
      transform_keys(&:to_sym)

      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        new(Yajl::Parser.parse(data))
      end

      # @return [String]
      def to_json
        to_hash.to_json
      end
    end
  end
end

Dir.glob("#{__dir__}/model/**/**/*.rb").sort.each do |file|
  require file
end

require 'k8s/api/metav1'
require 'k8s/api/version'
require 'k8s/model/apimachinery/apis/meta/v1/api_group_list'
require 'k8s/model/apimachinery/apis/meta/v1/api_resource_list'
