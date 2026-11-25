class ExampleFormatter
  attr_accessor :reference

  def initialize(reference)
    @reference = reference
    @format_string = nil
  end

  FORMATS = {
    ".000000000" => ".9N",
    "-07:00:00" => "%::z",
    "Dayofweek" => "%A",
    "DAYOFWEEK" => "%^A",
    ".000000" => ".%6N",
    "Century" => "%C",
    "January" => "%B",
    "JANUARY" => "%^B",
    "Zone::#" => "%::z",
    "Monday" => "%A",
    "MONDAY" => "%^A",
    "Zone:#" => "%:z",
    "-07:00" => "%:z",
    "-7000" => "%z",
    "Month" => "%B",
    "MONTH" => "%^B",
    "Zone#" => "%z",
    "Year" => "%Y",
    "2006" => "%Y",
    ".000" => ".%L",
    "D00#" => "%j",
    "H012" => "%I",
    "002" => "%j",
    "Jan" => "%b",
    "JAN" => "%^b",
    "Mon" => "%a",
    "MON" => "%^a",
    "MST" => "%Z",
    "M0#" => "%m",
    "Mth" => "%b",
    "MTH" => "%^b",
    "D0#" => "%d",
    "Day" => "%a",
    "DAY" => "%^a",
    "H24" => "%H",
    "H12" => "%l",
    "Min" => "%M",
    "Sec" => "%S",
    "15" => "%H",
    "06" => "%y",
    "01" => "%m",
    "02" => "%d",
    "03" => "%I",
    "PM" => "%p",
    "pm" => "%P",
    "04" => "%M",
    "05" => "%S",
    "Yr" => "%y",
    "M#" => "%-m",
    "D#" => "%-e",
    "AM" => "%p",
    "am" => "%P",
    "Z" => "%Z",
    "1" => "%-m",
    "2" => "%-e",
    "3" => "%l"}.freeze

  FORMAT_MATCHER = Regexp.union(FORMATS.keys)

  def format_string
    @format_string ||= reference.gsub(FORMAT_MATCHER, FORMATS)
  end

  def format(date)
    date.strftime(format_string)
  end
end
