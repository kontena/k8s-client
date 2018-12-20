# frozen_string_literal: true

require 'yaml'

module K8s
  module YAMLSafeLoadStream
    refine YAML.singleton_class do
      # A safe version of YAML.load_stream.
      # Parses a multi document stream and raises if it tries to instantiate any
      # non-standard classes
      #
      # @param yaml [String] yaml content
      # @param filename [String] filename to be used in exception messages
      # @yield [document] each document in the stream is yielded if a block is given
      # @return [Array] when a block is not given, returns an Array of documents
      def safe_load_stream(yaml, filename = nil)
        streams = []
        parse_stream(yaml, filename) do |stream|
          raise_if_tags(stream, filename)
          if block_given?
            yield stream.to_ruby
          else
            streams << stream.to_ruby
          end
        end
        streams unless block_given?
      end

      private

      def raise_if_tags(obj, filename = nil, doc_num = 1)
        doc_num += 1 if obj.is_a?(Psych::Nodes::Document)

        if obj.respond_to?(:tag)
          if tag = obj.tag
            unless tag.to_s.start_with?('tag:yaml.org,')
              message = "tag #{tag} encountered on line #{obj.start_line} column #{obj.start_column} of document #{doc_num}"
              message += " in file #{filename}" if filename
              raise Psych::DisallowedClass, message
            end
          end
        end

        return unless obj.respond_to?(:children)

        Array(obj.children).each do |child|
          raise_if_tags(child, filename, doc_num)
        end
      end
    end
  end
end