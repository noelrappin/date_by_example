module DateByExample
  # Word-style formatting: tokens like {{Month}} or {{Hour:12}}.
  # Names are case-insensitive; an all-caps name gives all-caps output.
  # Modifiers are case-insensitive. Unknown tokens are left as literal text.
  class WordFormatter < ExampleFormatter
    TOKENS = {
      # year
      "year" => "%Y",
      "year:short" => "%y",
      "yr" => "%y",
      "century" => "%C",

      # month
      "month" => "%B",
      "month:short" => "%b",
      "mon" => "%b",
      "month:01" => "%m",
      "month:1" => "%-m",
      "month:_1" => "%_m",
      "monthnum" => "%m",
      "monthnum:01" => "%m",
      "monthnum:1" => "%-m",
      "monthnum:_1" => "%_m",

      # day of month
      "date" => "%d",
      "date:01" => "%d",
      "date:1" => "%-d",
      "date:_1" => "%e",

      # day of year
      "dayofyear" => "%j",
      "dayofyear:001" => "%j",
      "dayofyear:1" => "%-j",
      "dayofyear:_1" => "%_j",

      # day of week
      "weekday" => "%A",
      "weekday:short" => "%a",
      "day" => "%a",

      # hour
      "hour" => "%I",
      "hour:012" => "%I",
      "hour:12" => "%-l",
      "hour:_12" => "%l",
      "hour:24" => "%H",
      "hour:024" => "%H",
      "hour:-24" => "%-H",
      "hour:_24" => "%k",
      "am" => "%p",
      "pm" => "%p",

      # minute
      "min" => "%M",
      "min:01" => "%M",
      "min:1" => "%-M",
      "min:_1" => "%_M",

      # second
      "sec" => "%S",
      "sec:01" => "%S",
      "sec:1" => "%-S",
      "sec:_1" => "%_S",
      "sec:00.000" => "%S.%L",
      "sec:00.000000" => "%S.%6N",
      "sec:00.000000000" => "%S.%9N",
      "sec:milli" => "%S.%L",
      "sec:micro" => "%S.%6N",
      "sec:nano" => "%S.%9N",
      "milli" => "%L",
      "micro" => "%6N",
      "nano" => "%9N",

      # time zone
      "zone" => "%Z",
      "zone:name" => "%Z",
      "zone:+0000" => "%z",
      "zone:offset" => "%z",
      "offset" => "%z",
      "zone:+00:00" => "%:z",
      "zone:+00:00:00" => "%::z"
    }.freeze

    TOKEN_MATCHER = /\{\{\w+(?::[^}]*)?\}\}/

    private

    def compile
      escape_percents(reference)
        .then { replace_tokens(it) }
    end

    def replace_tokens(str)
      str.gsub(TOKEN_MATCHER) { strftime_code(unwrap(it)) || it }
    end

    def strftime_code(body)
      TOKENS[body.downcase]&.then { style(it, body) }
    end

    def style(code, body)
      return "%P" if lowercase_meridian?(body)

      all_caps?(name_of(body)) ? upcase(code) : code
    end

    def escape_percents(string) = string.gsub("%", "%%")

    def unwrap(token) = token.delete_prefix("{{").delete_suffix("}}")

    def name_of(body) = body.split(":").first

    def lowercase_meridian?(body)
      %w[am pm].include?(body)
    end

    def all_caps?(name)
      name == name.upcase
    end

    def upcase(code)
      code.gsub("%", "%^")
    end
  end
end
