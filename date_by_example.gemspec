# frozen_string_literal: true

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
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Require MFA for gem pushes.
  # See: https://guides.rubygems.org/mfa-requirement-opt-in/
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .standard.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk", "~> 2.6"
end
