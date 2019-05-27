# frozen_string_literal: true

require 'base64'
require 'yaml'
require 'time'
require 'k8s/hash_struct'
require 'k8s/error'

module K8s
  class Config < K8s::HashStruct
    # Create a configuration instance.
    #
    # If the config param is omitted, automatic configuration is attempted.
    #
    # Look-up order:
    #   - KUBE_TOKEN, KUBE_CA, KUBE_SERVER environment variables
    #   - KUBECONFIG environment variable
    #   - $HOME/.kube/config file
    #   - In cluster configuration
    # @param config [Hash] configuration hash
    def initialize(config = self.class.defaults)
      super
    end

    def self.defaults
      {
        'apiVersion' => 'v1',
        'clusters' => [],
        'contexts' => [],
        'current-context' => nil,
        'kind' => 'Config',
        'preferences' => {},
        'users' => []
      }
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

    def self.autodiscovery
      from_env || from_in_cluster_config || from_kubeconfig || from_default_path || raise(K8s::Error::Configuration, "failed to discover configuration")
    end

    def self.from_file(path)
      new(YAML.safe_load(File.read(File.expand_path(path)), [Time, DateTime, Date], [], true, path))
    end
    singleton_class.send(:alias_method, :load_file, :from_file)

    def self.from_env
      return nil if ENV.values_at('KUBE_TOKEN', 'KUBE_CA', 'KUBE_SERVER').any? { |v| v.to_s.empty? }
      raise K8s::Error::Configuration, 'KUBE_CA does not seem to be base64 encoded' unless Base64.decode64(ENV['KUBE_CA']).match?(/CERTIFICATE/)

      build(server: ENV['KUBE_SERVER'], ca: ENV['KUBE_CA'], auth_token: Base64.strict_decode64(ENV['KUBE_TOKEN']))
    rescue ArgumentError
      raise K8s::Error::Configuration, 'KUBE_TOKEN does not seem to be base64 encoded'
    end

    # Loads configuration files listed in KUBE_CONFIG environment variable and
    # merge using the configuration merge rules, @see K8s::Config.merge
    def self.from_kubeconfig
      kubeconfig = ENV['KUBECONFIG']
      return nil if kubeconfig.to_s.empty?

      paths = kubeconfig.split(/(?!\\):/)

      paths.inject(from_file(paths.shift)) do |memo, other_cfg|
        memo.merge(from_file(other_cfg))
      end
    end

    def self.from_default_path
      path = [File.join(Dir.home, '.kube', 'config'), '/etc/kubernetes/admin.conf', '/etc/kubernetes/kubelet.conf'].find { |f| File.readable?(f) }
      return nil unless path

      from_file(path)
    end

    def self.from_in_cluster_config
      port = ENV['KUBERNETES_SERVICE_PORT_HTTPS']
      host = ENV['KUBERNETES_SERVICE_HOST']
      return nil if port.to_s.empty? || host.to_s.empty?

      ssl_ca_file = File.join((ENV['TELEPRESENCE_ROOT'] || '/'), 'var/run/secrets/kubernetes.io/serviceaccount/ca.crt')
      auth_token = File.read(File.join((ENV['TELEPRESENCE_ROOT'] || '/'), 'var/run/secrets/kubernetes.io/serviceaccount/token'))
      build(server: "https://#{host}:#{port}", ca: Base64.strict_encode64(File.read(ssl_ca_file)), auth_token: Base64.encode64(auth_token))
    end

    # Convert to YAML
    # @return [String]
    def to_s
      YAML.dump(self)
    end
    alias to_yaml to_s

    # Performs a merge of another config into the current instance
    # @param other [Pharos::Kube::Config]
    def merge!(other)
      other.each do |key, value|
        case key
        when 'clusters', 'contexts', 'users'
          value.each do |other_value|
            next if self[key].find { |c| c['name'] == other_value['name'] }

            self[key] << other_value
          end
        when 'current-context', 'preferences'
          self[key] = value
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
            old_value
          end
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

    # @param name [String]
    # @raise [K8s::Error::Configuration]
    # @return [K8s::Config::Context]
    def context(name = current_context)
      return nil if name.nil? || !key?('contexts')

      found = self['contexts'].find { |context| context['name'] == name }
      raise K8s::Error::Configuration, "context not found: #{name.inspect}" unless found

      found.context
    end

    # @param name [String]
    # @return [K8s::Config::Cluster]
    def cluster(name = context&.cluster)
      return nil if name.nil? || !key?('clusters')

      found = self['clusters'].find { |cluster| cluster.name == name }
      raise K8s::Error::Configuration, "cluster not found: #{name.inspect}" unless found

      found.cluster
    end

    # @param name [String]
    # @return [K8s::Config::User]
    def user(name = context&.user)
      return nil if name.nil? || !key?('users')

      found = self['users'].find { |user| user.name == name }
      raise K8s::Error::Configuration, "user not found: #{name.inspect}" unless found

      found.user
    end
  end
end
