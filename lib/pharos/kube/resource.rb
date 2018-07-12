require 'deep_merge'

module Pharos
  module Kube
    # generic untyped resource
    class Resource
      # @param data [Hash]
      # @return [self]
      def self.from_json(data)
        return new(**data)
      end

      # @param filename [String] file path
      # @return [Pharos::Kube::Resource]
      def self.from_file(filename)
        new(Pharos::Kube::YAML.load_file(filename))
      end

      # @param filename [String] file path
      # @return [Array<Pharos::Kube::Resource>]
      def self.from_files(path)
        Pharos::Kube::YAML.load_files(path).map{|data| new(data) }
      end

      attr_reader :kind, :apiVersion, :metadata

      def initialize(**attrs)
        @kind = attrs[:kind]
        @apiVersion = attrs[:apiVersion]
        @metadata = Pharos::Kube::API::MetaV1::ObjectMeta.new(**attrs[:metadata])
        @attrs = attrs
      end

      def attrs
        @attrs
      end

      # @return [Hash]
      def to_hash
        @attrs
      end

      # @return [String]
      def to_json(**options)
        to_hash.to_json(**options)
      end

      def [](attr)
        @attrs[attr]
      end

      # merge in fields
      #
      # @return [Pharos::Kube:Resource]
      def merge(**attrs)
        # deep clone attrs
        h = Marshal.load(Marshal.dump(@attrs))

        # merge in-place
        h.deep_merge!(attrs, overwrite_arrays: true)

        self.class.new(h)
      end
    end
  end
end
