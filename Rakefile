require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"

RSpec::Core::RakeTask.new(:spec)

task default: %i[spec standard]

desc "Benchmark Go-style and word-style formatting"
task :benchmark do
  require "benchmark"
  require_relative "lib/date_by_example"

  date = DateTime.new(2018, 6, 9, 13, 15)
  Benchmark.bm(5) do |x|
    x.report("go") do
      1_000_000.times { ExampleFormatter.for("2 Jan 06 15:04").format(date) }
    end
    x.report("word") do
      1_000_000.times { ExampleFormatter.for("{{Date:1}} {{Mon}} {{Yr}} {{Hour:24}}:{{Min}}").format(date) }
    end
  end
end
