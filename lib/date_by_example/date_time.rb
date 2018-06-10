class DateTime
  def by_example(example)
    ExampleFormatter.new(example).format(self)
  end
end
