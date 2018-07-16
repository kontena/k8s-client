require 'forwardable'

module Pharos
  module Kube
    class Error < StandardError
      class API < Error
        extend Forwardable

        attr_reader :method, :path, :code, :reason, :status

        # @param method [Integer] HTTP request method
        # @param path [Integer] HTTP request path
        # @param code [Integer] HTTP response code
        # @param reason [String] HTTP response reason
        # @param status [Pharos::Kube::API::MetaV1::Status]
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

      HTTP_STATUS_ERRORS = {}

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
      define_status_error 504, :ServerTimeout
    end
  end
end
