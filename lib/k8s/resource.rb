# frozen_string_literal: true

require 'hashdiff'
require 'forwardable'
require 'yaml/safe_load_stream'
require 'k8s/hash_struct'

module K8s
  # generic untyped resource
  class Resource < HashStruct
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

    alias original_merge merge

    # merge in fields
    #
    # @param attrs [Hash, K8s::Resource]
    # @return [K8s::Resource]
    def merge(attrs)
      self.class.new(
        Util.deep_merge(self, attrs, overwrite_arrays: true, merge_nil_values: true)
      )
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
      current_cfg = metadata.annotations&.dig(config_annotation.to_sym)
      return {} unless current_cfg

      current_hash = Yajl::Parser.parse(current_cfg)
      # kubectl adds empty metadata.namespace, let's fix it
      current_hash['metadata'].delete('namespace') if current_hash.dig('metadata', 'namespace').to_s.empty?

      current_hash
    end

    # @param config_annotation [String]
    # @return [Boolean]
    def can_patch?(config_annotation)
      !!metadata.annotations&.dig(config_annotation.to_sym)
    end

    # @param hash [Hash]
    # @return [Hash]
    def stringify_hash(hash)
      Yajl::Parser.parse(JSON.dump(hash))
    end
  end
end
