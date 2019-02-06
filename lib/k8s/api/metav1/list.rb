# frozen_string_literal: true

require 'k8s/model/apimachinery/apis/meta/v1/list_meta'

module K8s
  module API
    module MetaV1
      # @see https://godoc.org/k8s.io/apimachinery/pkg/apis/meta/v1#List
      class List < Resource
        attribute :metadata, K8s::Model::Apimachinery::Apis::Meta::V1::ListMeta
        attribute :items, Types::Strict::Array # untyped
      end
    end
  end
end
