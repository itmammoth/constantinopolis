# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'constantinopolis/version'

Gem::Specification.new do |spec|
  spec.name          = "constantinopolis"
  spec.version       = Constantinopolis::VERSION
  spec.authors       = ["itmammoth"]
  spec.email         = ["itmammoth@gmail.com"]
  spec.summary       = %q{Setting constants solution for ruby applications.}
  spec.description   = %q{Constantinopolis allows you to set constants from your ERBed YAML file. Remarkably, your constants are available not only in ruby context, but in javascript's. It works with Rails, Sinatra, or any Ruby projects.}
  spec.homepage      = "https://github.com/itmammoth/constantinopolis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "pry-byebug", "~> 3.4"
  spec.add_development_dependency "capybara", "~> 2.7"
  spec.add_development_dependency "launchy", "~> 2.4"
  spec.add_development_dependency "poltergeist", "~> 1.10"
  spec.add_development_dependency "sinatra", "~> 1.4"
end
