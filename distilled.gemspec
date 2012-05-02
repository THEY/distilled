$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "distilled/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "distilled"
  s.version     = Distilled::VERSION
  s.authors     = ["Christopher Yeoh"]
  s.email       = ["christoperyeoh@gmail.com"]
  s.homepage    = "http://shynnergy.com"
  s.summary     = "Filter rails logs by IPs."
  s.description = "Filter rails logs by IPs."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
