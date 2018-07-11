require 'securerandom'
require 'deep_merge'

module Pharos
  module Kube
    class Stack
      LABEL = 'pharos.kontena.io/stack'
      CHECKSUM_ANNOTATION = 'pharos.kontena.io/stack-checksum'
      PRUNE_IGNORE = [
        'v1:ComponentStatus', # apiserver ignores GET /v1/componentstatuses?labelSelector=... and returns all resources
        'v1:Endpoint', # inherits stack label from service, but not checksum annotation
      ]

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

      # @param resource [Pharos::Kube::Resource] to apply
      # @param merge_resource [Pharos::Kube::Resource] to merge additional attributes from
      # @return [Pharos::Kube::Resource]
      def prepare_resource(resource, merge_resource: nil)
        if merge_resource
          h = merge_resource.to_hash
          h.deep_merge!(resource.to_hash, overwrite_arrays: true)
        else
          h = resource.to_hash
        end

        # stack metadata
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
            client.create_resource(prepare_resource(resource))
          else
            client.update_resource(prepare_resource(resource, merge_resource: existing_resource))
          end
        end

        prune(client) if prune
      end

      def prune(client)
        client.apis(prefetch_resources: true).each do |api|
          api.list_resources(labelSelector: "#{LABEL}=#{name}").each do |resource|
            next if PRUNE_IGNORE.include? "#{resource.apiVersion}:#{resource.kind}"

            # XXX: map keys are symbols...
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
