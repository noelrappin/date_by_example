RSpec.describe ExampleFormatter do
  describe ".for" do
    specify { expect(described_class.for("Jan 2, 2006")).to be_a(DateByExample::GoFormatter) }
    specify { expect(described_class.for("{{Mon}} {{Date}}")).to be_a(DateByExample::WordFormatter) }
    specify { expect(described_class.for("2006 {{Year}}").format_string).to eq("2006 %Y") }
  end

  it "is abstract" do
    expect { described_class.new("2006") }.to raise_error(NotImplementedError)
  end

  it "requires subclasses to implement compile" do
    incomplete = Class.new(described_class)
    expect { incomplete.new("2006").format_string }.to raise_error(NotImplementedError)
  end

  describe "by_example methods" do
    let(:datetime) { DateTime.new(2018, 6, 5, 9, 4, 7) }
    let(:date) { Date.new(2018, 6, 5) }
    let(:time) { Time.new(2018, 6, 5, 9, 4, 7) }

    specify { expect(date.by_example("Jan 2, 2006")).to eq("Jun 5, 2018") }
    specify { expect(date.by_example("{{Mon}} {{Date:1}}, {{Year}}")).to eq("Jun 5, 2018") }
    specify { expect(datetime.by_example("{{Hour:24}}:{{Min}}")).to eq("09:04") }
    specify { expect(time.by_example("15:04")).to eq("09:04") }

    specify { expect(time.by_example_go("{{Year}} 2006")).to eq("{{Year}} 2018") }
    specify { expect(time.by_example_word("Version 2 {{Year}}")).to eq("Version 2 2018") }
  end
end
