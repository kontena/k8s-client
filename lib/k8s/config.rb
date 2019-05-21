# frozen_string_literal: true

require 'base64'
require 'yaml'
require 'time'
require 'k8s/hash_struct'

module K8s
  class Config < K8s::HashStruct
    # @param config [String, Hash, #read, #to_h] configuration content, hash or an IO object
    def initialize(config = nil)
      super(
        if config.nil?
          {
            'apiVersion' => 'v1',
            'clusters' => [],
            'contexts' => [],
            'current-context' => nil,
            'kind' => 'Config',
            'preferences' => {},
            'users' => []
          }
        elsif config.respond_to?(:read)
          parse_yaml(config.read, config.respond_to?(:path) ? config.path : nil)
        elsif config.is_a?(Hash)
          config
        elsif config.is_a?(String)
          if config.lines.size > 1
            parse_yaml(config)
          else
            parse_yaml(File.read(File.expand_path(config)), config)
          end
        elsif config.respond_to?(:to_h)
          config.to_h
        end
      )
    end

    # Convert to YAML
    # @return [String]
    def to_s
      YAML.dump(self)
    end
    alias to_yaml to_s

    def to_h
      self
    end

    # Performs a merge of another config into the current instance
    # @param other [Pharos::Kube::Config]
    def merge!(other)
      other.each do |key, value|
        case key
        when 'clusters', 'contexts', 'users'
          value.each do |other_value|
            own_value = self[key.to_s].find { |c| c['name'] == other_value['name'] }
            self[key.to_s] << other_value unless own_value
          end
        when 'current-context', 'preferences'
          self[key.to_s] = value
        else
          self[key.to_s] ||= value
        end
      end

      self
    end
    alias << merge!

    # Create a duplicate
    # @return [Pharos::Kube::Config]
    def dup
      self.class.new(self)
    end
    alias clone dup

    # Performs a merge and returns a new instance
    # @param other_config [Pharos::Kube::Config]
    # @return [Pharos::Kube::Config]
    def merge(other)
      dup << other
    end
    alias + merge

    # Loads a configuration from a YAML file
    #
    # TODO: deprecate
    # @param path [String]
    # @return [K8s::Config]
    def self.load_file(path)
      new(path)
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
    def self.build(server:, ca:, auth_token:, cluster_name: 'kubernetes', user: 'k8s-client', context: 'k8s-client')
      new(
        clusters: [{ name: cluster_name, cluster: { server: server, certificate_authority_data: ca } }],
        users: [{ name: user, user: { token: auth_token } }],
        contexts: [{ name: context, context: { cluster: cluster_name, user: user } }],
        current_context: context
      )
    end

    # @param name [String]
    # @raise [K8s::Error::Configuration]
    # @return [K8s::Config::Context]
    def context(name = current_context)
      found = (self['contexts'] || []).find { |context| context['name'] == name }
      raise K8s::Error::Configuration, "context not found: #{name.inspect}" unless found

      found.context
    end

    # @param name [String]
    # @return [K8s::Config::Cluster]
    def cluster(name = context.cluster)
      found = (self['clusters'] || []).find { |cluster| cluster.name == name }
      raise K8s::Error::Configuration, "cluster not found: #{name.inspect}" unless found

      found.cluster
    end

    # @param name [String]
    # @return [K8s::Config::User]
    def user(name = context.user)
      found = (self['users'] || []).find { |user| user.name == name }
      raise K8s::Error::Configuration, "user not found: #{name.inspect}" unless found

      found.user
    end

    private

    def parse_yaml(content, filename = nil)
      YAML.safe_load(content, [Time, DateTime, Date], [], true, filename)
    end
  end
end
