class ExampleFormatter

  attr_accessor :reference

  def initialize(reference)
    @reference = reference
    @format_string = nil
  end

  FORMATS = {
    "15" => "%H",
    "2006" => "%Y",
    "06" => "%y",
    "01" =>"%m",
    " 1" =>"%_m",
    "1" =>"%-m",
    "January" =>"%B",
    "JANUARY" =>"%^B",
    "Jan" =>"%b",
    "JAN" =>"%^b",
    "002" => "%j",
    "02" => "%d",
    " 2" => "%e",
    "2" => "%-e",
    "Monday" => "%A",
    "MONDAY" => "%^A",
    "Mon" => "%a",
    "MON" => "%^a",
    "03" => "%I",
    " 3" => "%l",
    "PM" => "%P",
    "pm" => "%m",
    "04" => "%M",
    "05" => "%S",
    ".000000000" => ".9N",
    ".000000" => ".%6N",
    ".000" => ".%L",
    "-7000" => "%z",
    "-07:00:00" => "%::z",
    "-07:00" => "%:z",
    "MST" => "%Z",
  }

  def format_string
    @format_string ||= begin
      FORMATS.each do |example, formatter|
        reference.gsub!(example, formatter)
      end
      reference
    end
  end

  def format(date)
    date.strftime(format_string)
  end

end
