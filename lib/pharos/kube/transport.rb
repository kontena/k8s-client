require 'excon'
require 'json'

module Pharos
  module Kube
    class Transport
      include Logging

      quiet! # do not log warnings by default

      EXCON_MIDDLEWARES = [
        # XXX: necessary? redirected requests omit authz headers?
        Excon::Middleware::RedirectFollower,
      ] + Excon.defaults[:middlewares]

      REQUEST_HEADERS = {
        'Accept' => 'application/json',
      }

      # Construct transport from kubeconfig
      #
      # @param config [Phraos::Kube::Config]
      # @return [Pharos::Kube::Transport]
      def self.config(config)
        options = {}

        if config.cluster.insecure_skip_tls_verify
          logger.debug "Using config with .cluster.insecure_skip_tls_verify"

          options[:ssl_verify_peer] = false
        end

        if path = config.cluster.certificate_authority
          logger.debug "Using config with .cluster.certificate_authority"

          options[:ssl_ca_file] = path
        end

        if data = config.cluster.certificate_authority_data
          logger.debug "Using config with .cluster.certificate_authority_data"

          ssl_cert_store = options[:ssl_cert_store] = OpenSSL::X509::Store.new
          ssl_cert_store.add_cert(OpenSSL::X509::Certificate.new(Base64.decode64(data)))
        end

        if (cert = config.user.client_certificate) && (key = config.user.client_key)
          logger.debug "Using config with .user.client_certificate/client_key"

          options[:client_cert] = cert
          options[:client_key] = key
        end

        if (cert_data = config.user.client_certificate_data) && (key_data = config.user.client_key_data)
          logger.debug "Using config with .user.client_certificate_data/client_key_data"

          options[:client_cert_data] = Base64.decode64(cert_data)
          options[:client_key_data] = Base64.decode64(key_data)
        end

        logger.info "Using config with server=#{config.cluster.server}"

        new(config.cluster.server, **options)
      end

      attr_reader :server, :options

      # @param server [String] URL with protocol://host:port - any /path is ignored
      def initialize(server, **options)
        @server = server
        @options = options

        logger! progname: @server
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

      # @return [Hash]
      def request_options(request_object: nil, **options)
        if request_object
          options[:headers] ||= {}
          options[:headers]['Content-Type'] = 'application/json'
          options[:body] = request_object.to_json
        end

        options
      end

      def format_request(options)
        method = options[:method]
        path = options[:path]
        body = nil

        if options[:query]
          path += Excon::Utils.query_string(options)
        end
        if obj = options[:request_object]
          body = "<#{obj.class.name}>"
        end

        [method, path, body].compact.join " "
      end

      # @raise [Pharos::Kube::Error]
      # @raise [Excon::Error] TODO: wrap
      # @return [response_class, Hash]
      def parse_response(response, request_options, response_class: nil)
        method = request_options[:method]
        path = request_options[:path]
        content_type, = response.headers['Content-Type'].split(';')

        case content_type
        when 'application/json'
          response_data = JSON.parse(response.body)

        when 'text/plain'
          response_data = response.body # XXX: broken if status 2xx
        else
          raise Pharos::Kube::Error::API.new(method, path, response.status, "Invalid response Content-Type: #{response.headers['Content-Type']}")
        end

        if response.status.between? 200, 299
          unless response_data.is_a? Hash
            raise Pharos::Kube::Error::API.new(method, path, response.status, "Invalid JSON response: #{response_data.inspect}")
          end

          if response_class
            return response_class.from_json(response_data)
          else
            return response_data # Hash
          end
        else
          error_class = Pharos::Kube::Error::HTTP_STATUS_ERRORS[response.status] || Pharos::Kube::Error::API

          if response_data.is_a?(Hash) && response_data['kind'] == 'Status'
            status = Pharos::Kube::API::MetaV1::Status.new(response_data)

            raise error_class.new(method, path, response.status, response.reason_phrase, status)
          else
            raise error_class.new(method, path, response.status, response.reason_phrase)
          end
        end
      end

      def request(response_class: nil, **options)
        excon_options = request_options(**options)

        start = Time.now
        response = excon.request(**excon_options)
        t = Time.now - start

        obj = parse_response(response, options,
          response_class: response_class,
        )
      rescue Pharos::Kube::Error::API => exc
        logger.warn { "#{format_request(options)} => HTTP #{exc.code} #{exc.reason} in #{'%.3f' % t}s"}
        logger.debug { "Request: #{excon_options[:body]}"} if excon_options[:body]
        logger.debug { "Response: #{response.body}"}
        raise
      else
        logger.info { "#{format_request(options)} => HTTP #{response.status}: <#{obj.class}> in #{'%.3f' % t}s"}
        logger.debug { "Request: #{excon_options[:body]}"} if excon_options[:body]
        logger.debug { "Response: #{response.body}"}
        return obj
      end

      # @param options [Array<Hash>]
      # @param skip_missing [Boolean] return nil for 404
      # @return [Array<response_class, Hash, nil>]
      def requests(*options, response_class: nil, skip_missing: false)
        return [] if options.empty? # excon chokes

        start = Time.now
        responses = excon.requests(
          options.map{|options| request_options(**options)}
        )
        objects = responses.zip(options).map{|response, request_options|
          begin
            parse_response(response, request_options,
              response_class: request_options[:response_class] || response_class,
            )
          rescue Pharos::Kube::Error::NotFound
            if skip_missing
              nil
            else
              raise
            end
          end
        }
        t = Time.now - start

      rescue Pharos::Kube::Error => exc
        logger.warn { "[#{options.map{|o| format_request(o)}.join ', '}] => HTTP #{exc.code} #{exc.reason} in #{'%.3f' % t}s"}
        raise
      else
        logger.info { "[#{options.map{|o| format_request(o)}.join ', '}] => HTTP [#{responses.map{|r| r.status}.join ', '}] in #{'%.3f' % t}s" }
        return objects
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
