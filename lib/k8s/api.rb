# frozen_string_literal: true

require 'k8s/hash_struct'

module K8s
  # Kube API definitions
  module API

    # Common API struct type, handling JSON transforms with symbol keys
    class Struct < K8s::HashStruct

      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        new(Yajl::Parser.parse(data))
      end
    end
  end
end
