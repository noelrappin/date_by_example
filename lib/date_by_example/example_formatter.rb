module DateByExample
  class ExampleFormatter
    def self.for(reference)
      (reference.include?("{{") ? WordFormatter : GoFormatter).new(reference)
    end

    attr_reader :reference

    def initialize(reference)
      if instance_of?(ExampleFormatter)
        raise NotImplementedError, "ExampleFormatter is abstract; use ExampleFormatter.for"
      end

      @reference = reference
      @format_string = nil
    end

    def format_string
      @format_string ||= compile
    end

    def format(date)
      date.strftime(format_string)
    end

    private

    def compile
      raise NotImplementedError, "#{self.class} must implement #compile"
    end
  end
end
