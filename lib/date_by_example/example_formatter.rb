class ExampleFormatter

  attr_accessor :reference

  def initialize(reference)
    @reference = reference
    @format_string = nil
  end

  FORMATS = {
    ".000000000" => ".9N",
    "-07:00:00" => "%::z",
    ".000000" => ".%6N",
    "January" =>"%B",
    "JANUARY" =>"%^B",
    "Monday" => "%A",
    "MONDAY" => "%^A",
    "-07:00" => "%:z",
    "-7000" => "%z",
    "2006" => "%Y",
    ".000" => ".%L",
    "002" => "%j",
    "Jan" =>"%b",
    "JAN" =>"%^b",
    "Mon" => "%a",
    "MON" => "%^a",
    "MST" => "%Z",
    "15" => "%H",
    "06" => "%y",
    "01" =>"%m",
    " 1" =>"%_m",
    "1" =>"%-m",
    "02" => "%d",
    " 2" => "%e",
    "03" => "%I",
    "PM" => "%P",
    "pm" => "%m",
    "04" => "%M",
    "05" => "%S",
    " 3" => "%l",
    "2" => "%-e",
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
