lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "date_by_example/version"

Gem::Specification.new do |spec|
  spec.name          = "date_by_example"
  spec.version       = DateByExample::VERSION
  spec.authors       = ["Noel Rappin"]
  spec.email         = ["noelrappin@gmail.com"]

  spec.summary       = "Go style date formatting by example"
  spec.description   = "Go style date formatting by example"
  spec.homepage      = "http://www.github.com/noelrappin/date_by_example"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.57"
  spec.add_development_dependency "rubocop-rspec", "~> 1.25"
end
