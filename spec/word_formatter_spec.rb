RSpec.describe DateByExample::WordFormatter do
  def format_string_for(str)
    described_class.new(str).format_string
  end

  def format_date(date, format)
    described_class.new(format).format(date)
  end

  let(:date) { DateTime.new(2018, 6, 5, 9, 4, 7.123456789r, "-05:00") }

  describe "years" do
    specify { expect(format_string_for("{{Year}}")).to eq("%Y") }
    specify { expect(format_string_for("{{Year:short}}")).to eq("%y") }
    specify { expect(format_string_for("{{Yr}}")).to eq("%y") }
    specify { expect(format_string_for("{{Century}}")).to eq("%C") }
  end

  describe "months" do
    specify { expect(format_string_for("{{Month}}")).to eq("%B") }
    specify { expect(format_string_for("{{Month:short}}")).to eq("%b") }
    specify { expect(format_string_for("{{Mon}}")).to eq("%b") }
    specify { expect(format_string_for("{{Month:01}}")).to eq("%m") }
    specify { expect(format_string_for("{{Month:1}}")).to eq("%-m") }
    specify { expect(format_string_for("{{Month:_1}}")).to eq("%_m") }
    specify { expect(format_string_for("{{MonthNum}}")).to eq("%m") }
    specify { expect(format_string_for("{{MonthNum:01}}")).to eq("%m") }
    specify { expect(format_string_for("{{MonthNum:1}}")).to eq("%-m") }
    specify { expect(format_string_for("{{MonthNum:_1}}")).to eq("%_m") }
  end

  describe "days" do
    specify { expect(format_string_for("{{Date}}")).to eq("%d") }
    specify { expect(format_string_for("{{Date:01}}")).to eq("%d") }
    specify { expect(format_string_for("{{Date:1}}")).to eq("%-d") }
    specify { expect(format_string_for("{{Date:_1}}")).to eq("%e") }
    specify { expect(format_string_for("{{DayOfYear}}")).to eq("%j") }
    specify { expect(format_string_for("{{DayOfYear:1}}")).to eq("%-j") }
    specify { expect(format_string_for("{{DayOfYear:_1}}")).to eq("%_j") }
    specify { expect(format_string_for("{{Weekday}}")).to eq("%A") }
    specify { expect(format_string_for("{{Weekday:short}}")).to eq("%a") }
    specify { expect(format_string_for("{{Day}}")).to eq("%a") }
  end

  describe "hours" do
    specify { expect(format_string_for("{{Hour}}")).to eq("%I") }
    specify { expect(format_string_for("{{Hour:012}}")).to eq("%I") }
    specify { expect(format_string_for("{{Hour:12}}")).to eq("%-l") }
    specify { expect(format_string_for("{{Hour:_12}}")).to eq("%l") }
    specify { expect(format_string_for("{{Hour:24}}")).to eq("%H") }
    specify { expect(format_string_for("{{Hour:024}}")).to eq("%H") }
    specify { expect(format_string_for("{{Hour:-24}}")).to eq("%-H") }
    specify { expect(format_string_for("{{Hour:_24}}")).to eq("%k") }
  end

  describe "meridian" do
    specify { expect(format_string_for("{{AM}}")).to eq("%^p") }
    specify { expect(format_string_for("{{PM}}")).to eq("%^p") }
    specify { expect(format_string_for("{{am}}")).to eq("%P") }
    specify { expect(format_string_for("{{pm}}")).to eq("%P") }
    specify { expect(format_date(date, "{{Am}}")).to eq("AM") }
    specify { expect(format_date(date, "{{pm}}")).to eq("am") }
  end

  describe "minutes and seconds" do
    specify { expect(format_string_for("{{Min}}")).to eq("%M") }
    specify { expect(format_string_for("{{Min:1}}")).to eq("%-M") }
    specify { expect(format_string_for("{{Min:_1}}")).to eq("%_M") }
    specify { expect(format_string_for("{{Sec}}")).to eq("%S") }
    specify { expect(format_string_for("{{Sec:1}}")).to eq("%-S") }
    specify { expect(format_date(date, "{{Sec:00.000}}")).to eq("07.123") }
    specify { expect(format_date(date, "{{Sec:00.000000}}")).to eq("07.123456") }
    specify { expect(format_date(date, "{{Sec:00.000000000}}")).to eq("07.123456789") }
    specify { expect(format_date(date, "{{Sec:Milli}}")).to eq("07.123") }
    specify { expect(format_date(date, "{{Sec:micro}}")).to eq("07.123456") }
    specify { expect(format_date(date, "{{Sec:NANO}}")).to eq("07.123456789") }
    specify { expect(format_date(date, "{{Sec}},{{Milli}}")).to eq("07,123") }
    specify { expect(format_date(date, "{{Micro}}")).to eq("123456") }
    specify { expect(format_date(date, "{{Nano}}")).to eq("123456789") }
  end

  describe "timezone" do
    specify { expect(format_string_for("{{Zone}}")).to eq("%Z") }
    specify { expect(format_string_for("{{Zone:name}}")).to eq("%Z") }
    specify { expect(format_date(date, "{{Zone:+0000}}")).to eq("-0500") }
    specify { expect(format_date(date, "{{Zone:offset}}")).to eq("-0500") }
    specify { expect(format_date(date, "{{Offset}}")).to eq("-0500") }
    specify { expect(format_date(date, "{{Zone:+00:00}}")).to eq("-05:00") }
    specify { expect(format_date(date, "{{Zone:+00:00:00}}")).to eq("-05:00:00") }
  end

  describe "case" do
    specify { expect(format_date(date, "{{MONTH}}")).to eq("JUNE") }
    specify { expect(format_date(date, "{{MON}}")).to eq("JUN") }
    specify { expect(format_date(date, "{{DAY}}")).to eq("TUE") }
    specify { expect(format_date(date, "{{WEEKDAY:short}}")).to eq("TUE") }
    specify { expect(format_date(date, "{{month}}")).to eq("June") }
    specify { expect(format_date(date, "{{MoNtH}}")).to eq("June") }
    specify { expect(format_date(date, "{{Weekday:SHORT}}")).to eq("Tue") }
    specify { expect(format_date(date, "{{DATE:1}}")).to eq("5") }
    specify { expect(format_date(date, "{{SEC:MILLI}}")).to eq("07.123") }
  end

  describe "edge cases" do
    specify { expect(format_date(date, "Version 2, {{Year}}")).to eq("Version 2, 2018") }
    specify { expect(format_date(date, "Today is {{Day}}, Jan 2")).to eq("Today is Tue, Jan 2") }
    specify { expect(format_date(date, "Minute Zone Daylight AMERICA")).to eq("Minute Zone Daylight AMERICA") }
    specify { expect(format_date(date, "100% {{Year}}")).to eq("100% 2018") }
    specify { expect(format_date(date, "%Y {{Year}}")).to eq("%Y 2018") }
    specify { expect(format_date(date, "{{Mnth}} {{Year}}")).to eq("{{Mnth}} 2018") }
    specify { expect(format_date(date, "{{Date:xx}}")).to eq("{{Date:xx}}") }
    specify { expect(format_date(date, "{{Date:%d}}")).to eq("{{Date:%d}}") }
    specify { expect(format_date(date, "{{Year")).to eq("{{Year") }
    specify { expect(format_date(date, "{{ Year }}")).to eq("{{ Year }}") }
    specify { expect(format_date(date, "{{{Year}}}")).to eq("{2018}") }
  end

  describe "can do date formats" do
    let(:date) { DateTime.new(2018, 6, 10, 13, 15) }

    specify { expect(format_date(date, "{{Mon}} {{Date:1}}, {{Year}}")).to eq("Jun 10, 2018") }
    specify { expect(format_date(date, "{{Month:01}}/{{Date}}/{{Yr}}")).to eq("06/10/18") }
    specify { expect(format_date(date, "{{Year}}-{{MonthNum}}-{{Date}}")).to eq("2018-06-10") }
    specify { expect(format_date(date, "{{Date:1}} {{Mon}} {{Yr}} {{Hour:24}}:{{Min}}")).to eq("10 Jun 18 13:15") }
    specify { expect(format_date(date, "{{Month}} {{Date}}, {{Year}} @ {{Hour}}:{{Min}}{{pm}}")).to eq("June 10, 2018 @ 01:15pm") }
  end
end
