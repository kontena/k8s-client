module Pharos
  module Kube
    def self.client(server, **options)
      Client.new(Transport.new(server, **options))
    end

    class Client
      # @param server [String] URL with protocol://host:port - any /path is ignored
      def initialize(transport)
        @transport = transport
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
