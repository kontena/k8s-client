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
          labels: { LABEL.to_sym => name }, # XXX: map keys are symbols...
          annotations: { CHECKSUM_ANNOTATION.to_sym => checksum }, # XXX: map keys are symbols...
        })

        Pharos::Kube::Resource.new(h)
      end

      # @return [Array<Pharos::Kube::Resource>]
      def apply(client, prune: true)
        resources.map do |resource|
          begin
            existing_resource = client.get_resource(resource)
          rescue Pharos::Kube::Error::NotFound
            client.create_resource(apply_resource(resource))
          else
            client.update_resource(apply_resource(resource, existing_resource))
          end
        end

        prune(client) if prune
      end

      def prune(client)
        client.apis(prefetch_resources: true).each do |api|
          api.list_resources(labelSelector: "#{LABEL}=#{name}").each do |resource|
            next if resource.apiVersion == 'v1' && resource.kind == 'ComponentStatus' # WTF: apiserver ignores the ?labelSelector query and returns everything
            next if resource.apiVersion == 'v1' && resource.kind == 'Endpoint' # inherits stack labels from service, does not have any ownerReference...

            resource_label = resource.metadata.labels ? resource.metadata.labels[LABEL.to_sym] : nil
            resource_checksum = resource.metadata.annotations ? resource.metadata.annotations[CHECKSUM_ANNOTATION.to_sym] : nil # XXX: map keys are symbols...

            if resource_label == name && resource_checksum != checksum
              client.delete_resource(resource)
            end
          end
        end
      end
    end
  end
end
