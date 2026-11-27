# DateByExample

Provides two kinds of date formatting that are hopefully easier to read than Ruby's native strftime.

The first kind is based on Go's string formatting and is based on a reference date of "Jan 2, 2006 at 3:04:05 PM MST", like `2006-01-02`

The second kind uses tokens as in `{{year}}` to provide a possibly easier to read, if more verbose option, so something like `{{year}}-{{monthnum}}-{{date}}`.

## Installation

This gem requires Ruby 3.4 and up.

Add this line to your application's Gemfile:

```ruby
gem 'date_by_example'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_by_example

## Usage

### Basic usage

This gem adds a `by_example` method to `Date`, `Time`, and `DateTime`.

The argument to this method is the formatted version of a reference date, in either format.

You get the word format if your string contains a `{{` token. Note that there's no way to escape this at the moment, if your Go-style string has a raw `{{`, you must use `by_example_go`. (In word format, content within `{{` delimiters that doesn't match a token is passed through unchanged.)

You can force a particular parser with `by_example_word` or `by_example_go`.

For example:

```
> d = Date.today
> d.by_example("2006-01-02")   => "2018-06-11"
> d.by_example("{{year}}-{{monthnum}}-{{date}}") => "2018-06-11"

> t = DateTime.now
> t.by_example("Jan 02 2006 @ 3:04 pm")  => "Jun 11 2018 @ 3:52 pm"
> t.by_example("{{Mon}} {{date}} {{year}} @ {{Hour:12}}:{{Min}} {{pm}}")  => "Jun 11 2018 @ 3:52 pm"

> t = Time.now
> t.by_example("Jan 02 2006 @ 3:04 pm")  => "Jun 11 2018 @ 3:53 pm"
> t.by_example("{{Mon}} {{date}} {{year}} @ {{Hour:12}}:{{Min}} {{pm}}")  => "Jun 11 2018 @ 3:53 pm"
```

The reference date is Jan 2, 2006 at 3:04:05 PM MST, which can be
remembered as 1 2 3 4 5 6 -7.

I realize that remembering the reference date is not the easy part,
but I think it's easier than remembering all the strftime format
strings.

### Format reference

Note that in word style, token matching is case-insensitive, except that an all-caps name will give all-caps output where that makes sense. Unknown tokens are ignored and passed through.

Note that in go style, there's no way to escape literal numbers that match go patterns. So `The 2nd date is: 2006-01` will match on the `2`. Likewise, an underscore right before a `2` is read as Go's space-padded day, so `2006_1_2` gives `2018_6 5`. If this is a problem, try word style.

Numbers are zero-padded by default.

Example time: Tuesday, June 5, 2018 at 1:04:07.123456789 PM CDT. A dash means that style has no equivalent.

| Unit | Output | Go style | Word style |
|---|---|---|---|
| Year | 2018 | `2006` | `{{Year}}` |
| | 18 | `06` | `{{Yr}}`, `{{Year:short}}` |
| | 20 | — | `{{Century}}` |
| Month | June | `January` | `{{Month}}` |
| | JUNE | `JANUARY` | `{{MONTH}}` |
| | Jun | `Jan` | `{{Mon}}`, `{{Month:short}}` |
| | JUN | `JAN` | `{{MON}}` |
| | 06 | `01` | `{{MonthNum}}`, `{{Month:01}}` |
| | 6 | `1` | `{{MonthNum:1}}`, `{{Month:1}}` |
| | `" 6"` | — | `{{MonthNum:_1}}`, `{{Month:_1}}` |
| Day of month | 05 | `02` | `{{Date}}`, `{{Date:01}}` |
| | 5 | `2` | `{{Date:1}}` |
| | `" 5"` | `_2` | `{{Date:_1}}` |
| Day of year | 156 | `002` | `{{DayOfYear}}` |
| | 156 (space padded) | `__2` | `{{DayOfYear:_1}}` |
| | 156 (unpadded) | — | `{{DayOfYear:1}}` |
| Weekday | Tuesday | `Monday` | `{{Weekday}}` |
| | TUESDAY | `MONDAY` | `{{WEEKDAY}}` |
| | Tue | `Mon` | `{{Day}}`, `{{Weekday:short}}` |
| | TUE | `MON` | `{{DAY}}` |
| Hour (24) | 13 (09 at 9am) | `15` | `{{Hour:24}}`, `{{Hour:024}}` |
| | 13 (9 at 9am) | — | `{{Hour:-24}}` |
| | 13 (`" 9"` at 9am) | — | `{{Hour:_24}}` |
| Hour (12) | 01 | `03` | `{{Hour}}`, `{{Hour:012}}` |
| | 1 | `3` | `{{Hour:12}}` |
| | `" 1"` | — | `{{Hour:_12}}` |
| AM/PM | PM | `PM` | `{{AM}}`, `{{PM}}` |
| | pm | `pm` | `{{am}}`, `{{pm}}` |
| Minute | 04 | `04` | `{{Min}}` |
| | 4 | — | `{{Min:1}}` |
| | `" 4"` | — | `{{Min:_1}}` |
| Second | 07 | `05` | `{{Sec}}` |
| | 7 | — | `{{Sec:1}}` |
| | `" 7"` | — | `{{Sec:_1}}` |
| | 07.123 | `05.000` | `{{Sec:Milli}}`, `{{Sec:00.000}}` |
| | 07.123456 | `05.000000` | `{{Sec:Micro}}`, `{{Sec:00.000000}}` |
| | 07.123456789 | `05.000000000` | `{{Sec:Nano}}`, `{{Sec:00.000000000}}` |
| Fraction | 123 | — | `{{Milli}}` |
| | 123456 | — | `{{Micro}}` |
| | 123456789 | — | `{{Nano}}` |
| Time zone | CDT | `MST` | `{{Zone}}`, `{{Zone:name}}` |
| | -0500 | `-0700` | `{{Offset}}`, `{{Zone:+0000}}`, `{{Zone:offset}}` |
| | -05:00 | `-07:00` | `{{Zone:+00:00}}` |
| | -05:00:00 | `-07:00:00` | `{{Zone:+00:00:00}}` |

### Unsupported Formats

This does not support Ruby's week based formats

### Alternate usage

The slow part of using this gem is generating the format string from
the example, if you want to reuse a format multiple times, you can do so
by creating and reusing an `ExampleFormatter` (or a `DateByExample::GoFormatter` or `DateByExample::WordFormatter` directly)

```
> ef = ExampleFormatter.for("01/02/06")
> ef.format(Date.today)   => "06/11/18"
> ef.format(Time.now)     => "06/11/18"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/noelrappin/date_by_example. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DateByExample project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/noelrappin/date_by_example/blob/main/CODE_OF_CONDUCT.md).
