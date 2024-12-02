require "./lib/loady/version"

Gem::Specification.new do |s|
  s.name        = "loady"
  s.version     = Loady::VERSION
  s.authors     = ["Tee Parham"]
  s.email       = %w[tee@neighborland.com]
  s.homepage    = "https://github.com/teeparham/loady"
  s.summary     = "File loader with simple logging"
  s.description = "File loader with simple logging"
  s.license     = "MIT"
  s.metadata["rubygems_mfa_required"] = "true"

  s.files         = Dir["LICENSE.txt", "README.md", "lib/**/*"]
  s.require_paths = %w[lib]


  s.add_development_dependency "minitest", "~> 5.5"
  s.add_development_dependency "mocha", "~> 1.1"
  s.add_development_dependency "rake", "~> 12.0"
  s.required_ruby_version = ">= 3.2.0"
end
