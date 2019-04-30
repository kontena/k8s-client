# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'
require 'base64'
require 'yaml'

module K8s
  # Common struct type for kubeconfigs:
  #
  # * converts string keys to symbols
  # * normalizes foo-bar to foo_bar
  class ConfigStruct < Dry::Struct
    transform_keys do |key|
      case key
      when String
        key.tr('-', '_').to_sym
      else
        key
      end
    end
  end

  # @see https://godoc.org/k8s.io/client-go/tools/clientcmd/api/v1#Config
  class Config < ConfigStruct
    # Common dry-types for config
    class Types
      include Dry::Types.module
    end

    # structured cluster
    class Cluster < ConfigStruct
      attribute :server, Types::String
      attribute :insecure_skip_tls_verify, Types::Bool.optional.default(nil)
      attribute :certificate_authority, Types::String.optional.default(nil)
      attribute :certificate_authority_data, Types::String.optional.default(nil)
      attribute :extensions, Types::Strict::Array.optional.default(nil)
    end

    # structured cluster with name
    class NamedCluster < ConfigStruct
      attribute :name, Types::String
      attribute :cluster, Cluster
    end

    # structured user auth provider
    class UserAuthProvider < ConfigStruct
      attribute :name, Types::String
      attribute :config, Types::Strict::Hash
    end

    # structured user exec
    class UserExec < ConfigStruct
      attribute :command, Types::String
      attribute :apiVersion, Types::String
      attribute :env, Types::Strict::Array.of(Types::Hash).optional.default(nil)
      attribute :args, Types::Strict::Array.of(Types::String).optional.default(nil)
    end

    # structured user
    class User < ConfigStruct
      attribute :client_certificate, Types::String.optional.default(nil)
      attribute :client_certificate_data, Types::String.optional.default(nil)
      attribute :client_key, Types::String.optional.default(nil)
      attribute :client_key_data, Types::String.optional.default(nil)
      attribute :token, Types::String.optional.default(nil)
      attribute :tokenFile, Types::String.optional.default(nil)
      attribute :as, Types::String.optional.default(nil)
      attribute :as_groups, Types::Array.of(Types::String).optional.default(nil)
      attribute :as_user_extra, Types::Hash.optional.default(nil)
      attribute :username, Types::String.optional.default(nil)
      attribute :password, Types::String.optional.default(nil)
      attribute :auth_provider, UserAuthProvider.optional.default(nil)
      attribute :exec, UserExec.optional.default(nil)
      attribute :extensions, Types::Strict::Array.optional.default(nil)
    end

    # structured user with name
    class NamedUser < ConfigStruct
      attribute :name, Types::String
      attribute :user, User
    end

    # structured context
    #
    # Referrs to other named User/cluster objects within the same config.
    class Context < ConfigStruct
      attribute :cluster, Types::Strict::String
      attribute :user, Types::Strict::String
      attribute :namespace, Types::Strict::String.optional.default(nil)
      attribute :extensions, Types::Strict::Array.optional.default(nil)
    end

    # named context
    class NamedContext < ConfigStruct
      attribute :name, Types::String
      attribute :context, Context
    end

    attribute :kind, Types::Strict::String.optional.default(nil)
    attribute :apiVersion, Types::Strict::String.optional.default(nil)
    attribute :preferences, Types::Strict::Hash.optional.default(proc { {} })
    attribute :clusters, Types::Strict::Array.of(NamedCluster).optional.default(proc { [] })
    attribute :users, Types::Strict::Array.of(NamedUser).optional.default(proc { [] })
    attribute :contexts, Types::Strict::Array.of(NamedContext).optional.default(proc { [] })
    attribute :current_context, Types::Strict::String.optional.default(nil)
    attribute :extensions, Types::Strict::Array.optional.default(proc { [] })

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
      old_attributes = attributes
      other_attributes = other.is_a?(Hash) ? other : other.attributes

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
      found = contexts.find{ |context| context.name == name }
      raise K8s::Error::Configuration, "context not found: #{name.inspect}" unless found

      found.context
    end

    # @param name [String]
    # @return [K8s::Config::Cluster]
    def cluster(name = context.cluster)
      clusters.find{ |cluster| cluster.name == name }.cluster
    end

    # @param name [String]
    # @return [K8s::Config::User]
    def user(name = context.user)
      users.find{ |user| user.name == name }.user
    end
  end
end
