# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hato/plugin/ikachan/version'

Gem::Specification.new do |spec|
  spec.name          = "hato-plugin-ikachan"
  spec.version       = Hato::Plugin::Ikachan::VERSION
  spec.authors       = ["Kentaro Kuribayashi"]
  spec.email         = ["kentarok@gmail.com"]
  spec.description   = %q{Hato plugin to send messages via Ikachan}
  spec.summary       = %q{Hato plugin to send messages via Ikachan}
  spec.homepage      = "https://github.com/kentaro/hato-plugin-ikachan"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.9.2'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "hato"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
