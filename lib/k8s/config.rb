# frozen_string_literal: true

require 'recursive-open-struct'
require 'base64'
require 'yaml'

module K8s
  # Common struct type for kubeconfigs:
  #
  # * converts string keys to symbols
  # * normalizes foo-bar to foo_bar
  # @see https://godoc.org/k8s.io/client-go/tools/clientcmd/api/v1#Config
  class Config < RecursiveOpenStruct
    module KeyTransformations
      def initialize(hash = self.class.defaults, args = {})
        super(hash.transform_keys { |k| k.to_s.tr('-', '_').to_sym }, args.merge(recurse_over_arrays: true))
      end

      def to_h
        super.transform_keys { |k| k.to_s.tr('_', '-').to_sym }
      end
    end

    class Child < RecursiveOpenStruct
      include KeyTransformations
    end

    include KeyTransformations

    def self.defaults
      {
        :apiVersion => 'v1',
        :clusters=> [],
        :contexts => [],
        :current_context => nil,
        :kind => 'Config',
        :preferences => {},
        :users => []
      }
    end

    # Loads a configuration from a YAML file
    #
    # @param path [String]
    # @return [K8s::Config]
    def self.load_file(path)
      new(YAML.safe_load(File.read(File.expand_path(path)), [Time, DateTime, Date], [], true))
    end

    # Loads configuration files listed in KUBE_CONFIG environment variable and
    # merge using the configuration merge rules, @see K8s::Config.merge
    #
    # @param kubeconfig [String] by default read from ENV['KUBECONFIG']
    def self.from_kubeconfig_env(kubeconfig = nil)
      kubeconfig ||= ENV.fetch('KUBECONFIG', '')
      raise ArgumentError, "KUBECONFIG not set" if kubeconfig.empty?

      paths = kubeconfig.split(/(?!\\):/)

      paths.inject(load_file(paths.shift)) do |memo, other_cfg|
        memo.merge(load_file(other_cfg))
      end
    end

    # Build a minimal configuration from at least a server address, server certificate authority data and an access token.
    #
    # @param server [String] kubernetes server address
    # @param ca [String] server certificate authority data (base64 encoded)
    # @param token [String] access token
    # @param cluster_name [String] cluster name
    # @param user [String] user name
    # @param context [String] context name
    # @param options [Hash] (see #initialize)
    def self.build(server:, ca:, auth_token:, cluster_name: 'kubernetes', user: 'k8s-client', context: 'k8s-client', **options)
      new(
        {
          clusters: [{ name: cluster_name, cluster: { server: server, certificate_authority_data: ca } }],
          users: [{ name: user, user: { token: auth_token } }],
          contexts: [{ name: context, context: { cluster: cluster_name, user: user } }],
          current_context: context
        }.merge(options)
      )
    end

    # Merges configuration according to the rules specified in
    # https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/#merging-kubeconfig-files
    #
    # @param other [Hash, K8s::Config]
    # @return [K8s::Config]
    def merge(other)
      old_attributes = to_h
      other_attributes = other.is_a?(Hash) ? other : other.to_h

      old_attributes.merge!(other_attributes) do |key, old_value, new_value|
        case key
        when :clusters, :contexts, :users
          old_value + new_value.reject do |new_mapping|
            old_value.any? { |old_mapping| old_mapping[:name] == new_mapping[:name] }
          end
        else
          case old_value
          when Array
            (old_value + new_value).uniq
          when Hash
            old_value.merge(new_value) do |_key, inner_old_value, inner_new_value|
              inner_old_value.nil? ? inner_new_value : inner_old_value
            end
          when NilClass
            new_value
          else
            warn "key is #{key} old val is #{old_value.inspect} and new val is #{new_value.inspect}"
            old_value
          end
        end
      end

      self.class.new(old_attributes)
    end

    # @param name [String]
    # @raise [K8s::Error::Configuration]
    # @return [K8s::Config::Context]
    def context(name = current_context)
      return nil if name.nil?

      contexts.find { |context| context.name == name }&.context || raise(K8s::Error::Configuration, "context not found: #{name.inspect}")
    end

    # @param name [String]
    # @raise [K8s::Error::Configuration]
    # @return [K8s::Config::Cluster]
    def cluster(name = context&.cluster)
      return nil if name.nil?

      clusters.find { |cluster| cluster.name == name }&.cluster || raise(K8s::Error::Configuration, "cluster not found: #{name.inspect}")
    end

    # @param name [String]
    # @raise [K8s::Error::Configuration]
    # @return [K8s::Config::User]
    def user(name = context&.user)
      return nil if name.nil?

      users.find { |user| user.name == name }&.user || raise(K8s::Error::Configuration, "user not found: #{name.inspect}")
    end

    private

    # Patch the RecursiveOpenStruct#recurse_over_array method to use a different child class
    def recurse_over_array(array)
      array.each_with_index do |a, i|
        if a.is_a?(Hash)
          array[i] = Child.new(
            a,
            recurse_over_arrays: true,
            mutate_input_hash: true,
            preserve_original_keys: @preserve_original_keys
          )
        elsif a.is_a?(Array)
          array[i] = recurse_over_array(a)
        end
      end
      array
    end
  end
end
