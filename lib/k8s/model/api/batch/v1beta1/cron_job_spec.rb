# frozen_string_literal: true

# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/batch/v1beta1"
require 'k8s/model/api/batch/v1beta1/job_template_spec'

module K8s::Model::Api::Batch::V1beta1
  class CronJobSpec < K8s::TypedResource
    # Specifies how to treat concurrent executions of a Job. Valid values are: - "Allow" (default): allows CronJobs to run concurrently; - "Forbid": forbids concurrent runs, skipping next run if previous run hasn't finished yet; - "Replace": cancels currently running job and replaces it with a new one
    # @return [K8s::API::Types::String,NilClass]
    attribute :concurrencyPolicy, K8s::API::Types::String.optional.default(nil)

    # The number of failed finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :failedJobsHistoryLimit, K8s::API::Types::Integer.optional.default(nil)

    # Specifies the job that will be created when executing a CronJob.
    # @return [K8s::Model::Api::Batch::V1beta1::JobTemplateSpec]
    attribute :jobTemplate, K8s::Model::Api::Batch::V1beta1::JobTemplateSpec

    # The schedule in Cron format, see https://en.wikipedia.org/wiki/Cron.
    # @return [K8s::API::Types::String]
    attribute :schedule, K8s::API::Types::String

    # Optional deadline in seconds for starting the job if it misses scheduled time for any reason.  Missed jobs executions will be counted as failed ones.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :startingDeadlineSeconds, K8s::API::Types::Integer.optional.default(nil)

    # The number of successful finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified. Defaults to 3.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :successfulJobsHistoryLimit, K8s::API::Types::Integer.optional.default(nil)

    # This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.  Defaults to false.
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :suspend, K8s::API::Types::Bool.optional.default(nil)

    register_paths []
  end
end
