# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'university_tickets/version'

Gem::Specification.new do |spec|
  spec.name          = "university_tickets"
  spec.version       = UniversityTickets::VERSION
  spec.authors       = ["James Kerr"]
  spec.email         = ["jkerr838@gmail.com"]
  spec.summary       = %q{A Ruby client wrapper for UniversityTicket's JSON API.}
  spec.description   = %q{Developed for Chapman University.}
  spec.homepage      = "https://github.com/chapmanu/university_tickets"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
