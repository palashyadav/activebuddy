require_relative "lib/active_buddy/version"

Gem::Specification.new do |spec|
  spec.name          = "active_buddy"
  spec.version       = ActiveBuddy::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["your@email.com"]

  spec.summary       = "AI-assisted model validator for Rails"
  spec.description   = "Suggests validations and associations for ActiveRecord models"
  spec.homepage      = "https://github.com/your_username/active_buddy"
  spec.license       = "MIT"

  spec.files = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_development_dependency "rspec"
end
