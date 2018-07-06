require 'excon'
require 'json'

module Pharos
  module Kube
    class Transport
      EXCON_MIDDLEWARES = [
        # XXX: necessary? redirected requests omit authz headers?
        Excon::Middleware::RedirectFollower,
      ] + Excon.defaults[:middlewares]

      REQUEST_HEADERS = {
        'Accept' => 'application/json',
      }

      # @param server [String] URL with protocol://host:port - any /path is ignored
      def initialize(server, **options)
        @server = server
        @options = options
      end

      # @return [Excon::Connection]
      def excon
        @excon ||= Excon.new(@server,
          persistent: true,
          middlewares: EXCON_MIDDLEWARES,
          headers: REQUEST_HEADERS,
          **@options
        )
      end

      # @return [String]
      def path(*path)
        File.join('/', *path)
      end

      def request(response_class: nil, **options)
        response = excon.request(**options)

        case response.headers['Content-Type']
        when 'application/json'
          response_data = JSON.parse(response.body,
            symbolize_names: true,
          )
        else
          # TODO: raise appropriate error
          fail "Unknown response type: #{response.headers['Content-Type']}"
        end

        if response_class
          response_value = response_class.new(**response_data)
        else
          response_value = response_data # Hash
        end

        if response.status.between? 200, 299
          return response_value
        elsif response_data.is_a?(Hash) && response_data[:kind] == 'Status'
          raise StandardError, response_data[:message] # XXX
        else
          raise StandardError, response.reason_phrase # XXX
        end
      end

      def get(*path, **options)
        request(
          method: 'GET',
          path: self.path(*path),
          **options,
        )
      end
    end
  end
end
