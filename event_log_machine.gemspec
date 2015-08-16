lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'event_log_machine/version'

Gem::Specification.new do |spec|
  spec.name          = "event_log_machine"
  spec.version       = EventLogMachine::VERSION
  spec.authors       = ["lionelbarrow"]
  spec.email         = ["lionelbarrow@gmail.com"]
  spec.summary       = "An eventual consistency aware state machine"
  spec.description   = "An eventual consistency aware state machine"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rgl", "~> 0.5"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
