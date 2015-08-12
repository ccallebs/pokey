require './lib/pokey/version'

Gem::Specification.new do |spec|
  spec.name          = "pokey"
  spec.version       = Pokey::VERSION.dup
  spec.authors       = ["Chuck Callebs"]
  spec.email         = ["chuck@callebs.io"]
  spec.summary       = %q{Automatically create HTTP requests in the background.}
  spec.description   = %q{Automatically create HTTP requests in the background. You can use
                          Pokey to simulate production webhooks on QA/development environments.}
  spec.homepage      = "https://github.com/ccallebs/pokey"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_runtime_dependency 'rufus-scheduler', '~> 3.1.2'
  spec.add_runtime_dependency 'logging'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
