require 'deep_merge'
require 'recursive-open-struct'

module K8s
  # generic untyped resource
  class Resource < RecursiveOpenStruct
    extend Forwardable
    include Comparable

    # @param data [Hash]
    # @return [self]
    def self.from_json(data)
      return new(data)
    end

    # @param filename [String] file path
    # @return [K8s::Resource]
    def self.from_file(filename)
      new(YAML.load_file(filename))
    end

    # @param filename [String] file path
    # @return [Array<K8s::Resource>]
    def self.from_files(path)
      stat = File.stat(path)

      if stat.directory?
        # recurse
        Dir.glob("#{path}/*.{yml,yaml}").sort.map{|path| self.from_files(path) }.flatten
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

    # @param other [K8s::Resource]
    # @return [Boolean]
    def <=>(other)
      to_hash <=> other.to_hash
    end

    # merge in fields
    #
    # @param attrs [Hash, K8s::Resource]
    # @return [K8s::Resource]
    def merge(attrs)
      # deep clone of attrs
      h = to_hash

      # merge in-place
      h.deep_merge!(attrs.to_hash, overwrite_arrays: true)

      self.class.new(h)
    end
  end
end
