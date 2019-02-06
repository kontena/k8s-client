# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop).tap do |task|
  task.options = %w(--fail-level A -S --format c)
  if RUBY_ENGINE == 'ruby' && RbConfig::CONFIG['host_os'] !~ /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    task.options << '--parallel'
  end
end

task default: [:spec, :rubocop]

desc "generate api models"
task :generate_models do
  require "k8s/model_generator"

  swagger = JSON.parse(File.read('./openapi/v1.13/swagger.json'))
  generator = K8s::ModelGenerator.new(swagger)
  generator.each_module do |path, contents|
    file = 'lib/' + path
    FileUtils.mkdir_p(File.dirname(file))
    File.write(file, contents)
  end

  generator.each_model do |path, model|
    file = 'lib/' + path + '.rb'
    FileUtils.mkdir_p(File.dirname(file))
    File.write(file, model)
  end
end
