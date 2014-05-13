# -*- encoding: utf-8 -*-
require "./lib/loady/version"

Gem::Specification.new do |s|
  s.name        = "loady"
  s.version     = Loady::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tee Parham"]
  s.email       = %w(tee@neighborland.com)
  s.homepage    = "http://github.com/teeparham/loady"
  s.summary     = %q{File loader with simple logging}
  s.description = %q{File loader with simple logging}
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = []
  s.require_paths = %w(lib)

  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency "mocha", "~> 1.0"
  s.add_development_dependency "rake", "~> 10.1"
  s.add_development_dependency "minitest", "~> 5.2"
end
