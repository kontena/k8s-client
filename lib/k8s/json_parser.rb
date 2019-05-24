# frozen_string_literal: true

require 'json'

module K8s
  module JSONParser
    # Standard library JSON -based JSON-parsing backend
    class Default
      # A simple buffer that accepts data through the `<<` method and yields its buffer when a
      # newline character is encountered.
      class LineBufferedIO
        def initialize(&block)
          @buffer = +''
          @parser = block
        end

        # @param data [String] partial JSON content
        def <<(data)
          chunks = data.rpartition("\n")
          tail = chunks.pop
          @buffer << chunks.join

          if @buffer.include?("\n")
            @buffer.each_line do |line|
              @parser.call(line) unless line.strip.empty?
            end

            @buffer.clear
          end

          @buffer << tail
        end
      end

      # @param input [String] JSON content
      # @return [Hash,Array,String,Integer,Float,DateTime] the parsed result
      def self.parse(input)
        JSON.parse(input)
      end

      # Instantiate a streaming parser.
      #
      # @example
      #   result = []
      #   parser = K8s::JSONParser::Default.new do |obj|
      #     result << obj
      #   end
      #   parser << '{"hello":"world"\n}'
      #   parser << '{"hello":"world"\n}'
      #   puts result.inspect
      #   # outputs:
      #   # [{ 'hello' => 'world' }, { 'hello' => 'world' }]
      def initialize(&block)
        @parser = LineBufferedIO.new do |data|
          block.call(JSON.parse(data))
        end
      end

      def <<(data)
        @parser << data
      end
    end

    def self.backend
      @backend ||= Default
    end

    # @param parser_class [Class] set a different JSON parser backend
    def self.backend=(parser_class)
      @backend = parser_class
    end

    # @param input [String] JSON content
    # @return [Object] parse outcome
    def self.parse(input)
      backend.parse(input)
    end


    # Instantiate a streaming JSON parser.
    #
    # @example
    #   result = []
    #   parser = K8s::JSONParser.new do |obj|
    #     result << obj
    #   end
    #   parser << '{"hello":"world"\n}'
    #   parser << '{"hello":"world"\n}'
    #   puts result.inspect
    #   # outputs:
    #   # [{ 'hello' => 'world' }, { 'hello' => 'world' }]
    # @return [K8s::JSONParser::Default,K8s::JSONParser::Yajl]
    def self.new(&block)
      backend.new(&block)
    end
  end
end
