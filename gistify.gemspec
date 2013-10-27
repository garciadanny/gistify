# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gistify/version'

Gem::Specification.new do |spec|
  spec.name          = "gistify"
  spec.version       = Gistify::VERSION
  spec.authors       = ["Danny Garcia"]
  spec.email         = ["dannygarcia.me@gmail.com"]
  spec.description   = %q{create gists from the command line}
  spec.summary       = %q{learning how to use thor to create gists from the command line}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.18.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "httparty", "~> 0.12.0"
  spec.add_development_dependency "vcr", "~> 2.6.0"
  spec.add_development_dependency "webmock", "~> 1.15.0"
end
