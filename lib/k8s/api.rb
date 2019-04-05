# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module K8s
  # Kube API definitions
  module API
    # Common Dry::Types used in the API
    module Types
      include Dry.Types()
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
      def to_json(*_args)
        to_hash.to_json
      end
    end
  end
end
