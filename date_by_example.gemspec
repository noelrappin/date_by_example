require_relative "lib/date_by_example/version"

Gem::Specification.new do |spec|
  spec.name = "date_by_example"
  spec.version = DateByExample::VERSION
  spec.authors = ["Noel Rappin"]
  spec.email = ["noelrappin@gmail.com"]

  spec.summary = "Format dates by example, Go-style or with readable {{Token}} templates"
  spec.description = <<~DESC
    Adds by_example to Date, Time, and DateTime. Format with Go's reference
    date ("Jan 2, 2006") or with word tokens ("{{Mon}} {{Date:1}}, {{Year}}")
    instead of memorizing strftime codes.
  DESC
  spec.homepage = "https://github.com/noelrappin/date_by_example"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["lib/**/*.rb", "README.md", "LICENSE.txt", "CHANGELOG.md"]
  spec.require_paths = ["lib"]
end
