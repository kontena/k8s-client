# frozen_string_literal: true

require 'yajl'

module K8s
  module JSONParser
    # Yajl JSON-parsing backend, with the native extension it's faster than the pure-ruby standard library JSON-parser.
    #
    # To use install, add `gem 'yajl-ruby'` to your gemfile and require this class: `require 'k8s/json_parser/yajl'`
    class Yajl
      # @param input [String] JSON content
      # @return [Hash,Array,String,Integer,Float,DateTime] the parsed result
      def self.parse(input)
        ::Yajl::Parser.parse(input)
      end

      # Instantiate a streaming parser.
      #
      # @example
      #   result = []
      #   parser = K8s::JSONParser::Yajl.new do |obj|
      #     result << obj
      #   end
      #   parser << '{"hello":"world"\n}'
      #   parser << '{"hello":"world"\n}'
      #   puts result.inspect
      #   # outputs:
      #   # [{ 'hello' => 'world' }, { 'hello' => 'world' }]
      def initialize(&block)
        @parser = ::Yajl::Parser.new.tap do |parser|
          parser.on_parse_complete = block
        end
      end

      # The block passed to #new will be executed for each complete document
      # @param data [String] partial JSON content
      def <<(data)
        @parser << data
      end
    end
  end
end

K8s::JSONParser.backend = K8s::JSONParser::Yajl
