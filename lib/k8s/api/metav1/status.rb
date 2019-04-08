# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Status
      class Status < Resource
        # structured cause
        class Cause < Struct
          attribute :reason, Types::String.optional.default(nil)
          attribute :message, Types::String.optional.default(nil) # human-readable
          attribute :field, Types::String.optional.default(nil) # human-readable
        end

        # structured details
        class Details < Struct
          attribute :name, Types::String.optional.default(nil)
          attribute :group, Types::String.optional.default(nil)
          attribute :kind, Types::String.optional.default(nil)
          attribute :uid, Types::String.optional.default(nil)
          attribute :causes, Types::Array.of(Cause).optional.default(nil)
          attribute :retryAfterSeconds, Types::Integer.optional.default(nil)
        end

        attribute :metadata, ListMeta
        attribute :status, Types::String.enum('Success', 'Failure').optional.default(nil)
        attribute :message, Types::String.optional.default(nil) # human-readable
        attribute :reason, Types::String.optional.default(nil) # machine-readable
        attribute :details, Details.optional.default(nil)
        attribute :code, Types::Integer.optional.default(nil)
      end
    end
  end
end
