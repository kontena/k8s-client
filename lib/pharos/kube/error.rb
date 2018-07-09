require 'forwardable'

module Pharos
  module Kube
    class Error < StandardError
      class API < Error

        # @param code [Integer] HTTP response code
        # @param reason [String] HTTP response reason
        def initialize(code, message)
          @code = code

          super(message)
        end
      end

      # API status error
      class Status < API
        extend Forwardable

        def_delegators :@status, :status, :message, :reason, :details, :code

        # @param status [Pharos::Kube::API::MetaV1::Status]
        def initialize(code, status)
          super(code, status.message)

          @status = status
        end
      end

      HTTP_STATUS_ERRORS = {}

      def self.define_status_error(code, name)
        HTTP_STATUS_ERRORS[code] = self.const_set(name, Class.new(Status))
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
