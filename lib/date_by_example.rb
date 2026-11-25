require "date"
require "date_by_example/version"
require "date_by_example/example_formatter"
require "date_by_example/go_formatter"
require "date_by_example/word_formatter"
require "date_by_example/by_example"
require "date_by_example/date"
require "date_by_example/time"

module DateByExample
  def self.benchmark
    require "benchmark"
    dt = DateTime.new(2018, 6, 9, 13, 15)
    Benchmark.bm do |x|
      x.report("go") do
        1_000_000.times { ExampleFormatter.for("2 Jan 06 15:04").format(dt) }
      end
      x.report("word") do
        1_000_000.times { ExampleFormatter.for("{{Date:1}} {{Mon}} {{Yr}} {{Hour:24}}:{{Min}}").format(dt) }
      end
    end
  end
end
