require 'securerandom'
require 'deep_merge'

module Pharos
  module Kube
    class Stack
      LABEL = 'pharos.kontena.io/stack'
      CHECKSUM_ANNOTATION = 'pharos.kontena.io/stack-checksum'

      def self.load(path, name: nil)
        new(name || File.basename(path), Pharos::Kube::Resource.from_files(path))
      end

      attr_reader :name, :resources

      def initialize(name, resources)
        @name = name
        @resources = resources
      end

      def checksum
        @checksum ||= SecureRandom.hex(16)
      end

      # @param resource [Pharos::Kube::Resource]
      # @param existing_resource [Pharos::Kube::Resource]
      # @return [Pharos::Kube::Resource]
      def apply_resource(resource, existing_resource = nil)
        h = existing_resource ? existing_resource.to_hash : {}
        h.deep_merge!(resource.to_hash, overwrite_arrays: true)
        h.deep_merge!(metadata: {
          labels: { LABEL => name },
          annotations: { CHECKSUM_ANNOTATION => checksum },
        })

        Pharos::Kube::Resource.new(h)
      end

      # @return [Array<Pharos::Kube::Resource>]
      def apply(client)
        resources.map do |resource|
          begin
            existing_resource = client.get_resource(resource)
          rescue Pharos::Kube::Error::NotFound
            client.create_resource(apply_resource(resource))
          else
            client.update_resource(apply_resource(resource, existing_resource))
          end
        end
      end
    end
  end
end
