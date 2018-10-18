# frozen_string_literal: true

module K8s
  module API
    # GET /version
    class Version < Struct
      attribute :buildDate, Types::Strict::String # TODO: parse datetime?
      attribute :compiler, Types::Strict::String
      attribute :gitCommit, Types::Strict::String
      attribute :gitTreeState, Types::Strict::String
      attribute :gitVersion, Types::Strict::String
      attribute :major, Types::Strict::String
      attribute :minor, Types::Strict::String
      attribute :platform, Types::Strict::String
    end
  end
end
