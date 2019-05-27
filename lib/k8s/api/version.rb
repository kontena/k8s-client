# frozen_string_literal: true

module K8s
  module API
    # GET /version
    class Version < Struct
      attribute :buildDate, K8s::Type::String
      attribute :compiler, K8s::Type::String
      attribute :gitCommit, K8s::Type::String
      attribute :gitTreeState, K8s::Type::String
      attribute :gitVersion, K8s::Type::String
      attribute :major, K8s::Type::String
      attribute :minor, K8s::Type::String
      attribute :platform, K8s::Type::String
    end
  end
end
