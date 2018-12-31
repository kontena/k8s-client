# frozen_string_literal: true

require 'deep_merge'
require 'recursive-open-struct'
require 'hashdiff'
require 'forwardable'
require 'yaml/safe_load_stream'

module K8s
  # generic untyped resource
  class Resource < RecursiveOpenStruct
    extend Forwardable
    include Comparable

    using YAMLSafeLoadStream

    # @param data [String]
    # @return [self]
    def self.from_json(data)
      new(Yajl::Parser.parse(data))
    end

    # @param filename [String] file path
    # @return [K8s::Resource]
    def self.from_file(filename)
      new(YAML.safe_load(File.read(filename), [], [], true, filename))
    end

    # @param path [String] file path
    # @return [Array<K8s::Resource>]
    def self.from_files(path)
      stat = File.stat(path)

      if stat.directory?
        # recurse
        Dir.glob("#{path}/*.{yml,yaml}").sort.map { |dir| from_files(dir) }.flatten
      else
        YAML.safe_load_stream(File.read(path), path).map{ |doc| new(doc) }
      end
    end

    # @param hash [Hash]
    # @param recurse_over_arrays [Boolean]
    # @param options [Hash] see RecursiveOpenStruct#initialize
    def initialize(hash, recurse_over_arrays: true, **options)
      super(hash,
        recurse_over_arrays: recurse_over_arrays,
        **options
      )
    end

    # @param options [Hash] see Hash#to_json
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

    # @return [String]
    def checksum
      @checksum ||= Digest::MD5.hexdigest(Marshal.dump(to_hash))
    end

    # @param attrs [Hash]
    # @param config_annotation [String]
    # @return [Hash]
    def merge_patch_ops(attrs, config_annotation)
      Util.json_patch(current_config(config_annotation), stringify_hash(attrs))
    end

    # Gets the existing resources (on kube api) configuration, an empty hash if not present
    #
    # @param config_annotation [String]
    # @return [Hash]
    def current_config(config_annotation)
      current_cfg = metadata.annotations&.dig(config_annotation)
      return {} unless current_cfg

      current_hash = Yajl::Parser.parse(current_cfg)
      # kubectl adds empty metadata.namespace, let's fix it
      current_hash['metadata'].delete('namespace') if current_hash.dig('metadata', 'namespace').to_s.empty?

      current_hash
    end

    # @param config_annotation [String]
    # @return [Boolean]
    def can_patch?(config_annotation)
      !!metadata.annotations&.dig(config_annotation)
    end

    # @param hash [Hash]
    # @return [Hash]
    def stringify_hash(hash)
      Yajl::Parser.parse(JSON.dump(hash))
    end
  end
end
