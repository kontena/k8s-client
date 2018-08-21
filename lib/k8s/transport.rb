require 'excon'
require 'json'

module K8s
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
    # @param config [K8s::Config]
    # @param server [String] override cluster.server from config
    # @param **overrides @see #initialize
    # @return [K8s::Transport]
    def self.config(config, server: nil, **overrides)
      options = {}

      server ||= config.cluster.server

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

      logger.info "Using config with server=#{server}"

      new(server, **options, **overrides)
    end

    # In-cluster config within a kube pod, using the kubernetes service envs and serviceaccount secrets
    #
    # @return [K8s::Transport]
    def self.in_cluster_config
      host = ENV['KUBERNETES_SERVICE_HOST']
      port = ENV['KUBERNETES_SERVICE_PORT_HTTPS']

      new("https://#{host}:#{port}",
        ssl_verify_peer: true,
        ssl_ca_file: '/var/run/secrets/kubernetes.io/serviceaccount/ca.crt',
        auth_token: File.read('/var/run/secrets/kubernetes.io/serviceaccount/token'),
      )
    end

    attr_reader :server, :options

    # @param server [String] URL with protocol://host:port - any /path is ignored
    # @param auth_token [String] optional Authorization: Bearer token
    # @param **options [Hash] @see Excon.new
    def initialize(server, auth_token: nil, **options)
      @server = server
      @auth_token = auth_token
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

    # @param *path [Array<String>] join path parts together to build the full URL
    # @return [String]
    def path(*path)
      File.join('/', *path)
    end

    # @param request_object [Object] include request body using to_json
    # @param content_type [String] request body content-type
    # @param **options [Hash] @see Excon#request
    # @return [Hash]
    def request_options(request_object: nil, content_type: 'application/json', **options)
      options[:headers] ||= {}

      if @auth_token
        options[:headers]['Authorization'] = "Bearer #{@auth_token}"
      end

      if request_object
        options[:headers]['Content-Type'] = content_type
        options[:body] = request_object.to_json
      end

      options
    end

    # @param options [Hash] as passed to Excon#request
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

    # @param response [Hash] as returned by Excon#request
    # @param request_options [Hash] as passed to Excon#request
    # @param response_class [Class] decode response body using #from_json
    # @raise [K8s::Error]
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
        raise K8s::Error::API.new(method, path, response.status, "Invalid response Content-Type: #{response.headers['Content-Type']}")
      end

      if response.status.between? 200, 299
        unless response_data.is_a? Hash
          raise K8s::Error::API.new(method, path, response.status, "Invalid JSON response: #{response_data.inspect}")
        end

        if response_class
          return response_class.from_json(response_data)
        else
          return response_data # Hash
        end
      else
        error_class = K8s::Error::HTTP_STATUS_ERRORS[response.status] || K8s::Error::API

        if response_data.is_a?(Hash) && response_data['kind'] == 'Status'
          status = K8s::API::MetaV1::Status.new(response_data)

          raise error_class.new(method, path, response.status, response.reason_phrase, status)
        elsif response_data
          raise error_class.new(method, path, response.status, "#{response.reason_phrase}: #{response_data}")
        else
          raise error_class.new(method, path, response.status, response.reason_phrase)
        end
      end
    end

    # @param response_class [Class] decode response body using #from_json
    # @param **options [Hash] @see Excon#request
    def request(response_class: nil, **options)
      excon_options = request_options(**options)

      start = Time.now
      response = excon.request(**excon_options)
      t = Time.now - start

      obj = parse_response(response, options,
        response_class: response_class,
      )
    rescue K8s::Error::API => exc
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

    # @param options [Array<Hash>] @see #request
    # @param skip_missing [Boolean] return nil for HTTP 404 responses
    # @param retry_errors [Boolean] retry with non-pipelined request for HTTP 503 responses
    # @param **common_options [Hash] @see #request, merged with the per-request options
    # @return [Array<response_class, Hash, nil>]
    def requests(*options, skip_missing: false, retry_errors: true, **common_options)
      return [] if options.empty? # excon chokes

      start = Time.now
      responses = excon.requests(
        options.map{|options| request_options(**common_options.merge(options))}
      )
      t = Time.now - start

      objects = responses.zip(options).map{|response, request_options|
        response_class = request_options[:response_class] || common_options[:response_class]

        begin
          parse_response(response, request_options,
            response_class: response_class,
          )
        rescue K8s::Error::NotFound
          if skip_missing
            nil
          else
            raise
          end
        rescue K8s::Error::ServiceUnavailable => exc
          if retry_errors
            logger.warn { "Retry #{format_request(request_options)} => HTTP #{exc.code} #{exc.reason} in #{'%.3f' % t}s" }

            # only retry the failed request, not the entire pipeline
            request(response_class: response_class, **common_options.merge(request_options))
          else
            raise
          end
        end
      }
    rescue K8s::Error => exc
      logger.warn { "[#{options.map{|o| format_request(o)}.join ', '}] => HTTP #{exc.code} #{exc.reason} in #{'%.3f' % t}s"}
      raise
    else
      logger.info { "[#{options.map{|o| format_request(o)}.join ', '}] => HTTP [#{responses.map{|r| r.status}.join ', '}] in #{'%.3f' % t}s" }
      return objects
    end

    # @param *path [Array<String>] @see #path
    # @param **options [Hash] @see #request
    def get(*path, **options)
      request(
        method: 'GET',
        path: self.path(*path),
        **options,
      )
    end

    # @param *paths [Array<String>]
    # @param **options [Hash] @see #request
    def gets(*paths, **options)
      requests(*paths.map{|path| {
          method: 'GET',
          path: self.path(path),
        } },
        **options
      )
    end
  end
end
