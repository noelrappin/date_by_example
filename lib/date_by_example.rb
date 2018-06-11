require "date"
require "date_by_example/date"
require "date_by_example/date_time"
require "date_by_example/time"
require "date_by_example/version"
require "date_by_example/example_formatter"
require "benchmark"

module DateByExample
  def self.benchmark
    dt = DateTime.new(2018, 6, 9, 13, 15)
    Benchmark.bm do |x|
      x.report do
        1_000_000.times do
          ExampleFormatter.new("2 Jan 06 15:04").format(dt)
        end
      end
    end

    # GSUB version is 16.15 seconds
  end
end
