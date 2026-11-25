module DateByExample
  module ByExample
    def by_example(example)
      ExampleFormatter.for(example).format(self)
    end

    def by_example_go(example)
      GoFormatter.new(example).format(self)
    end

    def by_example_word(example)
      WordFormatter.new(example).format(self)
    end
  end
end
