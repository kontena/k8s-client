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

      def parse_response(response, response_class: nil)
        case response.headers['Content-Type']
        when 'application/json'
          response_data = JSON.parse(response.body,
            symbolize_names: true,
          )
        else
          # TODO: raise appropriate error
          fail "Unknown response type: #{response.headers['Content-Type']}"
        end


        if response.status.between? 200, 299

        elsif response_data.is_a?(Hash) && response_data[:kind] == 'Status'
          raise StandardError, response_data[:message] # XXX
        else
          raise StandardError, response.reason_phrase # XXX
        end

        if response_class
          return response_class.new(**response_data)
        else
          return response_data # Hash
        end
      end

      def request(response_class: nil, **options)
        parse_response(excon.request(**options),
          response_class: response_class,
        )
      end

      # @param *options [Hash]
      def requests(*options, response_class: nil)
        excon.requests(options).map{|response| parse_response(response,
          response_class: response_class,
        ) }
      end

      # @param *path [String]
      def get(*path, **options)
        request(
          method: 'GET',
          path: self.path(*path),
          **options,
        )
      end

      # @param *paths [String]
      def gets(*paths, response_class: nil, **options)
        requests(*paths.map{|path| {
            method: 'GET',
            path: self.path(path),
            **options,
          } },
          response_class: response_class,
        )
      end
    end
  end
end
