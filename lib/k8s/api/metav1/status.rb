# frozen_string_literal: true

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#Status
      class Status < Resource
        # structured cause
        class Cause < Struct
          attribute :reason, K8s::Type::String
          attribute :message, K8s::Type::String
          attribute :field, K8s::Type::String
        end

        # structured details
        class Details < Struct
          attribute :name, K8s::Type::String
          attribute :group, K8s::Type::String
          attribute :kind, K8s::Type::String
          attribute :uid, K8s::Type::String
          attribute :causes, K8s::Type::Array.of(Cause), default: proc { [] }
          attribute :retryAfterSeconds, K8s::Type::Integer
        end

        attribute :metadata, ListMeta
        attribute :status, K8s::Type::String
        attribute :message, K8s::Type::String
        attribute :reason, K8s::Type::String
        attribute :details, Details
        attribute :code, K8s::Type::Integer
      end
    end
  end
end
