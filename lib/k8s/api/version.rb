# frozen_string_literal: true

module K8s
  module API
    # GET /version
    class Version < Struct
      attribute :buildDate, Types::String # TODO: parse datetime?
      attribute :compiler, Types::String
      attribute :gitCommit, Types::String
      attribute :gitTreeState, Types::String
      attribute :gitVersion, Types::String
      attribute :major, Types::String
      attribute :minor, Types::String
      attribute :platform, Types::String
    end
  end
end
