# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backlog/version'

Gem::Specification.new do |spec|
  spec.name          = "backlog"
  spec.version       = Backlog::VERSION
  spec.authors       = ["Sota Yokoe"]
  spec.email         = ["sota@pankaku.com"]
  spec.description   = %q{A library to Access Backlog Issue from Ruby. Forked from yoppi/backlog-api}
  spec.summary       = %q{Backlog API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
