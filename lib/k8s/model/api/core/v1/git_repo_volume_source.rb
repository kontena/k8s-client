# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/core/v1"


module K8s::Model::Api::Core::V1
  class GitRepoVolumeSource < K8s::TypedResource
    # Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name.
    # @return [K8s::API::Types::String,NilClass]
    attribute :directory, K8s::API::Types::String.optional.default(nil)

    # Repository URL
    # @return [K8s::API::Types::String]
    attribute :repository, K8s::API::Types::String

    # Commit hash for the specified revision.
    # @return [K8s::API::Types::String,NilClass]
    attribute :revision, K8s::API::Types::String.optional.default(nil)

    register_paths []
  end
end
