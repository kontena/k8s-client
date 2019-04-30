
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "k8s/client/version"

Gem::Specification.new do |spec|
  spec.name          = "k8s-client"
  spec.version       = K8s::Client::VERSION
  spec.authors       = ["Kontena, Inc."]
  spec.email         = ["info@kontena.io"]
  spec.license       = "Apache-2.0"

  spec.summary       = "Kubernetes client library"
  spec.homepage      = "https://github.com/kontena/k8s-client"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '~> 2.4'

  spec.add_runtime_dependency "excon", "~> 0.62.0"
  spec.add_runtime_dependency "dry-struct", "~> 0.5.0"
  spec.add_runtime_dependency "recursive-open-struct", "~> 1.1.0"
  spec.add_runtime_dependency 'hashdiff', '~> 0.3.7'
  spec.add_runtime_dependency 'jsonpath', '~> 0.9.5'
  spec.add_runtime_dependency 'yajl-ruby', '~> 1.4.0'
  spec.add_runtime_dependency "yaml-safe_load_stream", "~> 0.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "webmock", "~> 3.4.2"
  spec.add_development_dependency "rubocop", "~> 0.59"
end
