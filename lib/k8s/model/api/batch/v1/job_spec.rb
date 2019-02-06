# frozen_string_literal: true
# THIS FILE WAS AUTO GENERATED FROM THE K8S SWAGGER SPEC

require "k8s/typed_resource"
require "k8s/model/api/batch/v1"
require 'k8s/model/apimachinery/apis/meta/v1/label_selector'
require 'k8s/model/api/core/v1/pod_template_spec'

module K8s::Model::Api::Batch::V1
  class JobSpec < K8s::TypedResource
    # Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :activeDeadlineSeconds, K8s::API::Types::Integer.optional.default(nil)

    # Specifies the number of retries before marking this job failed. Defaults to 6
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :backoffLimit, K8s::API::Types::Integer.optional.default(nil)

    # Specifies the desired number of successfully finished pods the job should be run with.  Setting to nil means that the success of any pod signals the success of all pods, and allows parallelism to have any positive value.  Setting to 1 means that parallelism is limited to 1 and the success of that pod signals the success of the job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :completions, K8s::API::Types::Integer.optional.default(nil)

    # manualSelector controls generation of pod labels and pod selectors. Leave `manualSelector` unset unless you are certain what you are doing. When false or unset, the system pick labels unique to this job and appends those labels to the pod template.  When true, the user is responsible for picking unique labels and specifying the selector.  Failure to pick a unique label may cause this and other jobs to not function correctly.  However, You may see `manualSelector=true` in jobs that were created with the old `extensions/v1beta1` API. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#specifying-your-own-pod-selector
    # @return [K8s::API::Types::Bool,NilClass]
    attribute :manualSelector, K8s::API::Types::Bool.optional.default(nil)

    # Specifies the maximum desired number of pods the job should run at any given time. The actual number of pods running in steady state will be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism), i.e. when the work left to do is less than max parallelism. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :parallelism, K8s::API::Types::Integer.optional.default(nil)

    # A label query over pods that should match the pod count. Normally, the system sets this field for you. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
    # @return [K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector,NilClass]
    attribute :selector, K8s::Model::Apimachinery::Apis::Meta::V1::LabelSelector.optional.default(nil)

    # Describes the pod that will be created when executing a job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
    # @return [K8s::Model::Api::Core::V1::PodTemplateSpec]
    attribute :template, K8s::Model::Api::Core::V1::PodTemplateSpec

    # ttlSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes. This field is alpha-level and is only honored by servers that enable the TTLAfterFinished feature.
    # @return [K8s::API::Types::Integer,NilClass]
    attribute :ttlSecondsAfterFinished, K8s::API::Types::Integer.optional.default(nil)

    register_paths [
      
    ]
  end
end
