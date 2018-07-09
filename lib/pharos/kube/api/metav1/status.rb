module Pharos
  module Kube
    module API
      module MetaV1
        # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Status
        class Status < Resource

          class Cause < Dry::Struct
            attribute :reason, Types::Strict::String.optional.default(nil)
            attribute :message, Types::Strict::String.optional.default(nil) # human-readable
            attribute :field, Types::Strict::String.optional.default(nil) # human-readable
          end

          class Details < Dry::Struct
            attribute :name, Types::Strict::String.optional.default(nil)
            attribute :group, Types::Strict::String.optional.default(nil)
            attribute :kind, Types::Strict::String.optional.default(nil)
            attribute :uid, Types::Strict::String.optional.default(nil)
            attribute :causes, Types::Strict::Array.of(Cause).optional.default(nil)
            attribute :retryAfterSeconds, Types::Strict::Integer.optional.default(nil)
          end

          attribute :metadata do
            attribute :selfLink, Types::Strict::String.optional.default(nil)
            attribute :resourceVersion, Types::Strict::String.optional.default(nil)
            attribute :continue, Types::Strict::String.optional.default(nil)
          end

          attribute :status, Types::Strict::String.enum('Success', 'Failure').optional.default(nil)
          attribute :message, Types::Strict::String.optional.default(nil) # human-readable
          attribute :reason, Types::Strict::String.optional.default(nil) # machine-readable
          attribute :details, Details.optional.default(nil)
          attribute :code, Types::Strict::Integer.optional.default(nil)
        end
      end
    end
  end
end
