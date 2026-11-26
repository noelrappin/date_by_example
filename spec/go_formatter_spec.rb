RSpec.describe DateByExample::GoFormatter do
  def format_string_for(str)
    described_class.new(str).format_string
  end

  def format_date(date, format)
    described_class.new(format).format(date)
  end

  describe "years" do
    specify { expect(format_string_for("2006")).to eq("%Y") }
    specify { expect(format_string_for("06")).to eq("%y") }
    # ruby allows %C for the century, but 20 would be ambiguous with 2006
  end

  describe "months" do
    specify { expect(format_string_for("01")).to eq("%m") }
    specify { expect(format_string_for("1")).to eq("%-m") }
    specify { expect(format_string_for("January")).to eq("%B") }
    specify { expect(format_string_for("JANUARY")).to eq("%^B") }
    specify { expect(format_string_for("Jan")).to eq("%b") }
    specify { expect(format_string_for("JAN")).to eq("%^b") }
  end

  describe "days" do
    specify { expect(format_string_for("02")).to eq("%d") }
    specify { expect(format_string_for("_2")).to eq("%e") }
    specify { expect(format_string_for("2")).to eq("%-d") }
    specify { expect(format_string_for("002")).to eq("%j") }
    specify { expect(format_string_for("__2")).to eq("%_j") }
    specify { expect(format_string_for("Monday")).to eq("%A") }
    specify { expect(format_string_for("MONDAY")).to eq("%^A") }
    specify { expect(format_string_for("Mon")).to eq("%a") }
    specify { expect(format_string_for("MON")).to eq("%^a") }
  end

  describe "hours" do
    specify { expect(format_string_for("15")).to eq("%H") }
    specify { expect(format_string_for("03")).to eq("%I") }
    specify { expect(format_string_for("3")).to eq("%-l") }
    specify { expect(format_string_for("PM")).to eq("%p") }
    specify { expect(format_string_for("pm")).to eq("%P") }
  end

  describe "minutes and seconds" do
    specify { expect(format_string_for("04")).to eq("%M") }
    specify { expect(format_string_for("05")).to eq("%S") }
    specify { expect(format_string_for(".000")).to eq(".%L") }
    specify { expect(format_string_for(".000000")).to eq(".%6N") }
    specify { expect(format_string_for(".000000000")).to eq(".%9N") }
  end

  describe "timezone" do
    specify { expect(format_string_for("-0700")).to eq("%z") }
    specify { expect(format_string_for("-07:00")).to eq("%:z") }
    specify { expect(format_string_for("-07:00:00")).to eq("%::z") }
    specify { expect(format_string_for("MST")).to eq("%Z") }
  end

  # other things that can't be done here
  # %G -- week-based year
  # %g -- last two digits of week based year
  # %V -- week number of week based year
  # %U -- week number of year (sunday based)
  # %W -- week number of the year (monday based)
  # %s -- seconds since the epoch

  describe "edge cases" do
    let(:date) { DateTime.new(2018, 6, 5, 9, 4, 7.123456789r) }

    specify { expect(format_date(date, "05.000000000")).to eq("07.123456789") }
    specify { expect(format_date(date, "3pm")).to eq("9am") }
    specify { expect(format_date(date, "Jan _2")).to eq("Jun  5") }
    specify { expect(format_date(date, "__2")).to eq("156") }
    specify { expect(format_date(date, "%Y 2006")).to eq("%Y 2018") }
    specify { expect(format_date(date, "100%")).to eq("600%") } # same as Go
    specify { expect(format_date(date, "{{Year}}")).to eq("{{Year}}") }
  end

  describe "can do date formats" do
    let(:date) { DateTime.new(2018, 6, 10, 13, 15) }

    specify { expect(format_string_for("Jan 2, 2006")).to eq("%b %-d, %Y") }
    specify { expect(format_date(date, "Jan 2, 2006")).to eq("Jun 10, 2018") }
    specify { expect(format_date(date, "01/02/06")).to eq("06/10/18") }
    specify { expect(format_string_for("2 Jan 06 15:04")).to eq("%-d %b %y %H:%M") }
    specify { expect(format_date(date, "2 Jan 06 15:04")).to eq("10 Jun 18 13:15") }
    specify { expect(format_date(date, "January 02, 2006 @ 03:04pm")).to eq("June 10, 2018 @ 01:15pm") }
  end
end
