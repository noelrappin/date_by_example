require "date"
require "zeitwerk"

module DateByExample
end

loader = Zeitwerk::Loader.for_gem
loader.setup

Date.include(DateByExample::ByExample)
Time.include(DateByExample::ByExample)

# Top-level name from 0.1, kept for compatibility
ExampleFormatter = DateByExample::ExampleFormatter
