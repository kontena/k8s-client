require 'dry-struct'
require 'dry-types'
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
        key.gsub('-', '_').to_sym
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
      attribute :auth_provider, Types::Strict::Hash.optional.default(nil)
      attribute :exec, Types::Strict::Hash.optional.default(nil)
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
    attribute :preferences, Types::Strict::Hash.optional
    attribute :clusters, Types::Strict::Array.of(NamedCluster)
    attribute :users, Types::Strict::Array.of(NamedUser)
    attribute :contexts, Types::Strict::Array.of(NamedContext)
    attribute :current_context, Types::Strict::String
    attribute :extensions, Types::Strict::Array.optional.default(nil)

    # @param path [String]
    # @return [K8s::Config]
    def self.load_file(path)
      return new(YAML.load_file(path))
    end

    # TODO: raise error if not found
    # @return [K8s::Config::Context]
    def context(name = current_context)
      contexts.find{|context| context.name == name}.context
    end

    # @return [K8s::Config::Cluster]
    def cluster(name = context.cluster)
      clusters.find{|cluster| cluster.name == name}.cluster
    end

    # @return [K8s::Config::User]
    def user(name = context.user)
      users.find{|user| user.name == name}.user
    end
  end
end
