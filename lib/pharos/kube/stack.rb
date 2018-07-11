require 'securerandom'
require 'deep_merge'

module Pharos
  module Kube
    class Stack
      include Logging

      LABEL = 'pharos.kontena.io/stack'
      CHECKSUM_ANNOTATION = 'pharos.kontena.io/stack-checksum'
      PRUNE_IGNORE = [
        'v1:ComponentStatus', # apiserver ignores GET /v1/componentstatuses?labelSelector=... and returns all resources
        'v1:Endpoints', # inherits stack label from service, but not checksum annotation
      ]

      def self.load(path, name: nil, **options)
        new(name || File.basename(path), Pharos::Kube::Resource.from_files(path))
      end

      attr_reader :name, :resources

      def initialize(name, resources, debug: false)
        @name = name
        @resources = resources

        logger! progname: name, debug: debug
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
          logger.debug { "Applying resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace}..." }
          begin
            existing_resource = client.get_resource(resource)
          rescue Pharos::Kube::Error::NotFound
            logger.info "Create resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace}"
            client.create_resource(prepare_resource(resource))
          else
            logger.info "Update resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace}"
            client.update_resource(prepare_resource(resource, merge_resource: existing_resource))
          end
        end

        prune(client) if prune
      end

      def prune(client)
        client.apis(prefetch_resources: true).each do |api|
          logger.debug { "List resources in #{api.api_version}..."}

          api.list_resources(labelSelector: "#{LABEL}=#{name}").each do |resource|
            next if PRUNE_IGNORE.include? "#{resource.apiVersion}:#{resource.kind}"

            # XXX: map keys are symbols...
            resource_label = resource.metadata.labels ? resource.metadata.labels[LABEL.to_sym] : nil
            resource_checksum = resource.metadata.annotations ? resource.metadata.annotations[CHECKSUM_ANNOTATION.to_sym] : nil # XXX: map keys are symbols...

            logger.debug { "List resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace} with checksum=#{resource_checksum}" }

            if resource_label != name
              # apiserver did not respect labelSelector
            elsif resource_checksum == checksum
              # resource is up-to-date
            else
              logger.info "Delete resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace}"
              client.delete_resource(resource)
            end
          end
        end
      end
    end
  end
end
