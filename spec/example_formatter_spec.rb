RSpec.describe ExampleFormatter do

  def format_string_for(str)
    ExampleFormatter.new(str).format_string
  end

  def format_date(date, format)
    ExampleFormatter.new(format).format(date)
  end

  describe "years" do

    specify { expect(format_string_for("2006")).to eq("%Y") }
    specify { expect(format_string_for("06")).to eq("%y") }
    # ruby allows "%C for century, but I think we can't allow that here
    # because 20 is be ambiguous with 201

    specify { expect(format_string_for("Year")).to eq("%Y") }
    specify { expect(format_string_for("Yr")).to eq("%y") }
    specify { expect(format_string_for("Century")).to eq("%C") }

  end

  describe "months" do

    specify { expect(format_string_for("01")).to eq("%m") }
    # ruby has "%_m" for space padding, but we're not doing that
    specify { expect(format_string_for("1")).to eq("%-m") }

    specify { expect(format_string_for("M0#")).to eq("%m") }
    specify { expect(format_string_for("M#")).to eq("%-m") }

    specify { expect(format_string_for("January")).to eq("%B") }
    specify { expect(format_string_for("JANUARY")).to eq("%^B") }
    specify { expect(format_string_for("Month")).to eq("%B") }
    specify { expect(format_string_for("MONTH")).to eq("%^B") }


    specify { expect(format_string_for("Mth")).to eq("%b") }
    specify { expect(format_string_for("MTH")).to eq("%^b") }

  end

  describe "day of month" do

    specify { expect(format_string_for("02")).to eq("%d") }
    # ruby has "%e" for space padding, but we're not doing that
    specify { expect(format_string_for("2")).to eq("%-e") }
    specify { expect(format_string_for("002")).to eq("%j") }

    specify { expect(format_string_for("D0#")).to eq("%d") }
    specify { expect(format_string_for("D#")).to eq("%-e") }
    specify { expect(format_string_for("D00#")).to eq("%j") }

    specify { expect(format_string_for("Monday")).to eq("%A") }
    specify { expect(format_string_for("MONDAY")).to eq("%^A") }

    specify { expect(format_string_for("Dayofweek")).to eq("%A") }
    specify { expect(format_string_for("DAYOFWEEK")).to eq("%^A") }

    specify { expect(format_string_for("Mon")).to eq("%a") }
    specify { expect(format_string_for("MON")).to eq("%^a") }

    specify { expect(format_string_for("Day")).to eq("%a") }
    specify { expect(format_string_for("DAY")).to eq("%^a") }
    # ruby's numerical days of the week %u, %w probably can't be done

  end

  describe "hours" do
    specify { expect(format_string_for("15")).to eq("%H") }
    # ruby has %k for blank padded 24 hour clock but I can't do that here
    specify { expect(format_string_for("03")).to eq("%I") }
    specify { expect(format_string_for("3")).to eq("%l") }

    specify { expect(format_string_for("H24")).to eq("%H") }
    # ruby has %k for blank padded 24 hour clock but I can't do that here
    specify { expect(format_string_for("H012")).to eq("%I") }
    specify { expect(format_string_for("H12")).to eq("%l") }


    # ruby has "%l" for space padding, but we're not doing that
    specify { expect(format_string_for("PM")).to eq("%p") }
    specify { expect(format_string_for("pm")).to eq("%P") }
    specify { expect(format_string_for("AM")).to eq("%p") }
    specify { expect(format_string_for("am")).to eq("%P") }
  end

  describe "minutes and seconds" do
    specify { expect(format_string_for("04")).to eq("%M") }
    specify { expect(format_string_for("05")).to eq("%S") }
    specify { expect(format_string_for(".000")).to eq(".%L") }
    specify { expect(format_string_for(".000000")).to eq(".%6N") }
    specify { expect(format_string_for(".000000000")).to eq(".9N") }

    specify { expect(format_string_for("Min")).to eq("%M") }
    specify { expect(format_string_for("Sec")).to eq("%S") }
  end

  describe "timezone" do
    specify { expect(format_string_for("-7000")).to eq("%z") }
    specify { expect(format_string_for("-07:00")).to eq("%:z") }
    specify { expect(format_string_for("-07:00:00")).to eq("%::z") }
    specify { expect(format_string_for("MST")).to eq("%Z") }

    specify { expect(format_string_for("Zone#")).to eq("%z") }
    specify { expect(format_string_for("Zone:#")).to eq("%:z") }
    specify { expect(format_string_for("Zone::#")).to eq("%::z") }
    specify { expect(format_string_for("Z")).to eq("%Z") }
  end

  # other things that can't be done here
  # %G -- week-based year
  # %g -- last two digits of week based year
  # %V -- week number of week based year
  # %U -- week number of year (sunday based)
  # %W -- week number of the year (monday based)
  # %s -- seconds since the epoch

  describe "can do date formats" do
    let(:date) { DateTime.new(2018, 6, 10, 13, 15) }

    specify { expect(format_string_for("Jan 2, 2006")).to eq("%b %-e, %Y") }
    specify { expect(format_date(date, "Jan 2, 2006")).to eq("Jun 10, 2018") }
    specify { expect(format_date(date, "01/02/06")).to eq("06/10/18") }
    specify { expect(format_string_for("2 Jan 06 15:04")).to eq("%-e %b %y %H:%M") }
    specify { expect(format_date(date, "2 Jan 06 15:04")).to eq("10 Jun 18 13:15") }
    specify { expect(date.by_example("Jan 2, 2006")).to eq("Jun 10, 2018") }
    specify { expect(date.by_example("January 02, 2006 @ 03:04pm")).to eq("June 10, 2018 @ 01:15pm") }

    specify { expect(format_string_for("Mth D#, Year")).to eq("%b %-e, %Y") }
    specify { expect(format_date(date, "Mth D#, Year")).to eq("Jun 10, 2018") }
    specify { expect(format_date(date, "M0#/D0#/Yr")).to eq("06/10/18") }
    specify { expect(format_string_for("D# Mth Yr H24:Min")).to eq("%-e %b %y %H:%M") }
    specify { expect(format_date(date, "D# Mth Yr H24:Min")).to eq("10 Jun 18 13:15") }
    specify { expect(date.by_example("Mth D#, Year")).to eq("Jun 10, 2018") }
    specify { expect(date.by_example("Month D0#, Year @ H012:Minpm")).to eq("June 10, 2018 @ 01:15pm") }
  end

end
