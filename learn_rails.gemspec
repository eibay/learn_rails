# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'learn_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "learn_rails"
  spec.version       = LearnRails::VERSION
  spec.authors       = ["Peter-Jan Celis"]
  spec.email         = ["pj@celis.org"]
  spec.description   = spec.summary
  spec.summary       = %q{Gem learn_rails shows you the ruby code behind rails magic.}
  spec.homepage      = "http://github.com/pjc/learn_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.0.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
end
