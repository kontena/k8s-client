require 'deep_merge'
require 'recursive-open-struct'

module Pharos
  module Kube
    # generic untyped resource
    class Resource < RecursiveOpenStruct
      extend Forwardable

      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        return new(data)
      end

      # @param filename [String] file path
      # @return [Pharos::Kube::Resource]
      def self.from_file(filename)
        new(YAML.load_file(filename))
      end

      # @param filename [String] file path
      # @return [Array<Pharos::Kube::Resource>]
      def self.from_files(path)
        stat = File.stat(path)

        if stat.directory?
          Dir.glob("#{path}/*.{yml,yaml}").map{|path| self.load_files(path) }.flatten
        else
          ::YAML.load_stream(File.read(path), path).map{|doc| new(doc) }
        end
      end

      # @param attrs [Hash]
      def initialize(hash, recurse_over_arrays: true, **options)
        super(hash,
          recurse_over_arrays: recurse_over_arrays,
          **options
        )
      end

      # @return [String]
      def to_json(**options)
        to_hash.to_json(**options)
      end

      # merge in fields
      #
      # @return [Pharos::Kube::Resource]
      def merge(attrs)
        # deep clone of attrs
        h = to_hash

        # merge in-place
        h.deep_merge!(attrs, overwrite_arrays: true)

        self.class.new(h)
      end
    end
  end
end
