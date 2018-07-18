require 'dry-types'
require 'dry-struct'

module K8s
  module API
    module Types
      include Dry::Types.module
    end

    class Struct < Dry::Struct
      # input from JSON with string keys
      transform_keys(&:to_sym)

      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        return new(data)
      end

      # @return [String]
      def to_json
        to_hash.to_json
      end
    end
  end
end
