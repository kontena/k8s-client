require 'deep_merge'
require 'recursive-open-struct'
require 'hashdiff'

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

    # @param path [String] file path
    # @return [Array<K8s::Resource>]
    def self.from_files(path)
      stat = File.stat(path)

      if stat.directory?
        # recurse
        Dir.glob("#{path}/*.{yml,yaml}").sort.map { |dir| self.from_files(dir) }.flatten
      else
        ::YAML.load_stream(File.read(path), path).map{|doc| new(doc) }
      end
    end

    # @param hash [Hash]
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
      h.deep_merge!(attrs.to_hash, overwrite_arrays: true, merge_nil_values: true)

      self.class.new(h)
    end

    def checksum
      @checksum ||= Digest::MD5.hexdigest(Marshal::dump(to_hash))
    end

    def merge_patch_ops(attrs, config_annotation)
      Util.json_patch(current_config(config_annotation), stringify_hash(attrs))
    end

    # Gets the existing resources (on kube api) configuration, an empty hash if not present
    #
    # @return [Hash]
    def current_config(config_annotation)
      current_cfg = self.metadata.annotations&.dig(config_annotation)
      return {} unless current_cfg

      current_hash = JSON.parse(current_cfg)
      # kubectl adds empty metadata.namespace, let's fix it
      current_hash['metadata'].delete('namespace') if current_hash.dig('metadata', 'namespace').to_s.empty?

      current_hash
    end

    def can_patch?(config_annotation)
      !!self.metadata.annotations&.dig(config_annotation)
    end

    def stringify_hash(hash)
      JSON.load(JSON.dump(hash))
    end
  end
end
