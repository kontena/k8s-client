require 'openssl'
require 'base64'

module Pharos
  module Kube
    def self.client(server, **options)
      Client.new(Transport.new(server, **options))
    end

    class Client
      # @param config [Phraos::Kube::Config]
      # @return [Pharos::Kube::Client]
      def self.config(config)
        options = {}

        if config.cluster.insecure_skip_tls_verify
          options[:ssl_verify_peer] = false
        end

        if path = config.cluster.certificate_authority
          options[:ssl_ca_file] = path
        end

        if data = config.cluster.certificate_authority_data
          ssl_cert_store = options[:ssl_cert_store] = OpenSSL::X509::Store.new
          ssl_cert_store.add_cert(OpenSSL::X509::Certificate.new(Base64.decode64(data)))
        end

        if (cert = config.user.client_certificate) && (key = config.user.client_key)
          options[:client_cert] = cert
          options[:client_key] = key
        end

        if (cert_data = config.user.client_certificate_data) && (key_data = config.user.client_key_data)
          options[:client_cert_data] = Base64.decode64(cert_data)
          options[:client_key_data] = Base64.decode64(key_data)
        end

        transport = Transport.new(config.cluster.server, **options)

        new(transport)
      end

      # @param server [String] URL with protocol://host:port - any /path is ignored
      def initialize(transport, namespace: nil)
        @transport = transport
        @namespace = namespace
        
        @api_clients = {}
      end

      # @return [Hash{major, minor, ...}]
      def version
        @transport.get('/version')
      end

      # @param api_version [String] "group/version" or "version" (core)
      # @return [APIClient]
      def api(api_version = 'v1')
        @api_clients[api_version] ||= APIClient.new(@transport, api_version)
      end
    end
  end
end
