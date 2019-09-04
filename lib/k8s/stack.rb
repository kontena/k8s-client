# frozen_string_literal: true

require 'securerandom'

module K8s
  # Usage: customize the LABEL and CHECKSUM_ANNOTATION
  class Stack
    include Logging

    # Label used to identify resources belonging to this stack
    LABEL = 'k8s.kontena.io/stack'

    # Annotation used to identify resource versions
    CHECKSUM_ANNOTATION = 'k8s.kontena.io/stack-checksum'

    # Annotation used to identify last applied configuration
    LAST_CONFIG_ANNOTATION = 'kubectl.kubernetes.io/last-applied-configuration'

    # List of apiVersion:kind combinations to skip for stack prune
    # These would lead to stack prune misbehaving if not skipped.
    PRUNE_IGNORE = [
      'v1:ComponentStatus', # apiserver ignores GET /v1/componentstatuses?labelSelector=... and returns all resources
      'v1:Endpoints' # inherits stack label from service, but not checksum annotation
    ].freeze

    # @param name [String] unique name for stack
    # @param path [String] load resources from YAML files
    # @param options [Hash] see Stack#initialize
    # @return [K8s::Stack]
    def self.load(name, path, **options)
      resources = K8s::Resource.from_files(path)
      new(name, resources, **options)
    end

    # @param name [String] unique name for stack
    # @param path [String] load resources from YAML files
    # @param client [K8s::Client] apply using client
    # @param prune [Boolean] delete old resources
    # @param options [Hash] see Stack#initialize
    # @return [K8s::Stack]
    def self.apply(name, path, client, prune: true, **options)
      load(name, path, **options).apply(client, prune: prune)
    end

    # Remove any installed stack resources.
    #
    # @param name [String] unique name for stack
    # @param client [K8s::Client] apply using client
    def self.delete(name, client, **options)
      new(name, **options).delete(client)
    end

    attr_reader :name, :resources

    # @param name [String]
    # @param resources [Array<K8s::Resource>]
    # @param debug [Boolean]
    # @param label [String]
    # @param checksum_annotation [String]
    # @param last_config_annotation [String]
    def initialize(name, resources = [], debug: false, label: self.class::LABEL, checksum_annotation: self.class::CHECKSUM_ANNOTATION, last_configuration_annotation: self.class::LAST_CONFIG_ANNOTATION)
      @name = name
      @resources = resources
      @keep_resources = {}
      @label = label
      @checksum_annotation = checksum_annotation
      @last_config_annotation = last_configuration_annotation

      logger! progname: name, debug: debug
    end

    # @param resource [K8s::Resource] to apply
    # @param base_resource [K8s::Resource] DEPRECATED
    # @return [K8s::Resource]
    # rubocop:disable Lint/UnusedMethodArgument
    def prepare_resource(resource, base_resource: nil)
      # TODO: base_resource is not used anymore, kept for backwards compatibility for a while

      # calculate checksum  only from the "local" source
      checksum = resource.checksum

      # add stack metadata
      resource.merge(
        metadata: {
          labels: { @label => name },
          annotations: {
            @checksum_annotation => checksum,
            @last_config_annotation => Util.recursive_compact(resource.to_h).to_json
          }
        }
      )
    end
    # rubocop:enable Lint/UnusedMethodArgument

    # @param client [K8s::Client]
    # @return [Array<K8s::Resource>]
    def apply(client, prune: true)
      server_resources = client.get_resources(resources)

      resources.zip(server_resources).map do |resource, server_resource|
        if !server_resource
          logger.info "Create resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace} with checksum=#{resource.checksum}"
          keep_resource! client.create_resource(prepare_resource(resource))
        elsif server_resource.metadata&.ownerReferences && !server_resource.metadata.ownerReferences.empty?
          logger.info "Server resource #{server_resource.apiVersion}:#{server_resource.apiKind}/#{server_resource.metadata.name} in namespace #{server_resource.metadata.namespace} has an ownerReference and will be kept"
          keep_resource! server_resource
        elsif server_resource.metadata&.annotations&.dig(@checksum_annotation) != resource.checksum
          logger.info "Update resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace} with checksum=#{resource.checksum}"
          r = prepare_resource(resource)
          if server_resource.can_patch?(@last_config_annotation)
            keep_resource! client.patch_resource(server_resource, server_resource.merge_patch_ops(r.to_h, @last_config_annotation))
          else
            # try to update with PUT
            keep_resource! client.update_resource(server_resource.merge(prepare_resource(resource)))
          end
        else
          logger.info "Keep resource #{server_resource.apiVersion}:#{server_resource.kind}/#{server_resource.metadata.name} in namespace #{server_resource.metadata.namespace} with checksum=#{server_resource.metadata.annotations[@checksum_annotation]}"
          keep_resource! server_resource
        end
      end

      prune(client, keep_resources: true) if prune
    end

    # key MUST NOT include resource.apiVersion: the same kind can be aliased in different APIs
    # @param resource [K8s::Resource]
    # @return [K8s::Resource]
    def keep_resource!(resource)
      @keep_resources["#{resource.kind}:#{resource.metadata.name}@#{resource.metadata.namespace}"] = resource.metadata&.annotations.dig(@checksum_annotation)
    end

    # @param resource [K8s::Resource]
    # @return [Boolean]
    def keep_resource?(resource)
      keep_annotation = @keep_resources["#{resource.kind}:#{resource.metadata.name}@#{resource.metadata.namespace}"]
      return false unless keep_annotation

      keep == resource.metadata&.annotations&.dig(@checksum_annotation)
    end

    # Delete all stack resources that were not applied
    # @param client [K8s::Client]
    # @param keep_resources [NilClass, Boolean]
    # @param skip_forbidden [Boolean]
    def prune(client, keep_resources:, skip_forbidden: true)
      # using skip_forbidden: assume we can't create resource types that we are forbidden to list, so we don't need to prune them either
      client.list_resources(labelSelector: { @label => name }, skip_forbidden: skip_forbidden).sort do |a, b|
        # Sort resources so that namespaced objects are deleted first
        if a.metadata.namespace == b.metadata.namespace
          0
        elsif a.metadata.namespace.nil? && !b.metadata.namespace.nil?
          1
        else
          -1
        end
      end.each do |resource|
        next if PRUNE_IGNORE.include? "#{resource.apiVersion}:#{resource.kind}"

        resource_label = resource.metadata&.labels&.dig(@label)
        resource_checksum = resource.metadata&.annotations&.dig(@checksum_annotation)

        logger.debug { "List resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace} with checksum=#{resource_checksum}" }


        if resource_label != name
          # apiserver did not respect labelSelector
        elsif keep_resources && keep_resource?(resource)
          # resource is up-to-date
        else
          logger.info "Delete resource #{resource.apiVersion}:#{resource.kind}/#{resource.metadata.name} in namespace #{resource.metadata.namespace}"
          begin
            client.delete_resource(resource, propagationPolicy: 'Background')
          rescue K8s::Error::NotFound => e
            # assume aliased objects in multiple API groups, like for Deployments
            # alternatively, a custom resource whose definition was already deleted earlier
            logger.debug { "Ignoring #{e} : #{e.message}" }
          end
        end
      end
    end

    # Delete all stack resources
    # @param client [K8s::Client]
    def delete(client)
      prune(client, keep_resources: false)
    end
  end
end
