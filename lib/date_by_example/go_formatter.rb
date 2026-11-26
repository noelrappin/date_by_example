module DateByExample
  # Go-style formatting: the format is the reference time
  # Mon Jan 2 15:04:05 MST 2006, written the way you want the output to look.

  class GoFormatter < ExampleFormatter
    FORMATS = {
      # year
      "2006" => "%Y",
      "06" => "%y",

      # month
      "January" => "%B",
      "JANUARY" => "%^B",
      "Jan" => "%b",
      "JAN" => "%^b",
      "01" => "%m",
      "1" => "%-m",

      # day
      "02" => "%d",
      "_2" => "%e",
      "2" => "%-d",
      "002" => "%j",
      "__2" => "%_j",
      "Monday" => "%A",
      "MONDAY" => "%^A",
      "Mon" => "%a",
      "MON" => "%^a",

      # hour
      "15" => "%H",
      "03" => "%I",
      "3" => "%-l",
      "PM" => "%p",
      "pm" => "%P",

      # minute and second
      "04" => "%M",
      "05" => "%S",
      ".000" => ".%L",
      ".000000" => ".%6N",
      ".000000000" => ".%9N",

      # time zone
      "MST" => "%Z",
      "-0700" => "%z",
      "-07:00" => "%:z",
      "-07:00:00" => "%::z",

      # a literal percent sign must not reach strftime unescaped
      "%" => "%%"
    }.freeze

    FORMAT_MATCHER = Regexp.union(FORMATS.keys.sort_by { -it.length })

    private

    def compile
      reference.gsub(FORMAT_MATCHER, FORMATS)
    end
  end
end
