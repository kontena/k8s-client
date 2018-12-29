# frozen_string_literal: true

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

    BadRequest = Class.new(API).freeze
    Unauthorized = Class.new(API).freeze
    Forbidden = Class.new(API).freeze
    NotFound = Class.new(API).freeze
    MethodNotAllowed = Class.new(API).freeze
    Conflict = Class.new(API).freeze # XXX: also AlreadyExists?
    Invalid = Class.new(API).freeze
    Timeout = Class.new(API).freeze
    InternalError = Class.new(API).freeze
    ServiceUnavailable = Class.new(API).freeze
    ServerTimeout = Class.new(API).freeze

    HTTP_STATUS_ERRORS = {
      400 => BadRequest,
      401 => Unauthorized,
      403 => Forbidden,
      404 => NotFound,
      405 => MethodNotAllowed,
      409 => Conflict,
      422 => Invalid,
      429 => Timeout,
      500 => InternalError,
      503 => ServiceUnavailable,
      504 => ServerTimeout
    }.freeze

    # Attempt to create a ResourceClient for an unknown resource type.
    # The client cannot construct the correct API URL without having the APIResource definition.
    UndefinedResource = Class.new(Error)

    Configuration = Class.new(Error)
  end
end
