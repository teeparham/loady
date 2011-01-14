# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "loady/version"

Gem::Specification.new do |s|
  s.name        = "loady"
  s.version     = Loady::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tee Parham"]
  s.email       = ["tee@stackpilot.com"]
  s.homepage    = ""
  s.summary     = %q{CSV file loader with simple logging}
  s.description = %q{CSV file loader with simple logging}

  s.rubyforge_project = "loady"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "test-unit"
  s.add_development_dependency "shoulda"
end
