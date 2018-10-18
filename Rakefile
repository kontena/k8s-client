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
