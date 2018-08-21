require 'forwardable'

module K8s
  # Top-level class for all errors raised by this gem.
  class Error < StandardError

    # Kube API error, related to a HTTP response with a non-2xx code
    class API < Error
      extend Forwardable

      attr_reader :method, :path, :code, :reason, :status

      # @param method [Integer] HTTP request method
      # @param path [Integer] HTTP request path
      # @param code [Integer] HTTP response code
      # @param reason [String] HTTP response reason
      # @param status [K8s::API::MetaV1::Status]
      def initialize(method, path, code, reason, status = nil)
        @method = method
        @path = path
        @code = code
        @reason = reason
        @status = status

        if status
          super("#{@method} #{@path} => HTTP #{@code} #{@reason}: #{@status.message}")
        else
          super("#{@method} #{@path} => HTTP #{@code} #{@reason}")
        end
      end
    end

    # specific API error subtypes for HTTP status codes
    # Hash{Integer => Class<API>}
    HTTP_STATUS_ERRORS = {}

    # define a new API error type on the module for the given HTTP status code
    #
    # @param code [Integer] HTTP status code
    # @param name [Symbol] API error class name
    def self.define_status_error(code, name)
      HTTP_STATUS_ERRORS[code] = self.const_set(name, Class.new(API))
    end

    define_status_error 400, :BadRequest
    define_status_error 401, :Unauthorized
    define_status_error 403, :Forbidden
    define_status_error 404, :NotFound
    define_status_error 405, :MethodNotAllowed
    define_status_error 409, :Conflict # XXX: also AlreadyExists?
    define_status_error 422, :Invalid
    define_status_error 429, :Timeout
    define_status_error 500, :InternalError
    define_status_error 503, :ServiceUnavailable
    define_status_error 504, :ServerTimeout

    # Attempt to create a ResourceClient for an unknown resource type.
    # The client cannot construct the correct API URL without having the APIResource definition.
    class UndefinedResource < Error

    end
  end
end
