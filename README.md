# DateByExample

Provides a Ruby implementation of Go-style date formatting by example

## Installation

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

The argument to this method is the formatted version of a reference date.

For example:

```
> d = Date.today
> d.by_example("2006-01-02")   => "2018-06-11"

> t = DateTime.now
> t.by_example("Jan 02 2006 @ 3:04 pm")  => "Jun 11 2018 @ 3:52 pm"

> t = Time.now
> t.by_example("Jan 02 2006 @ 3:04 pm")  => "Jun 11 2018 @ 3:53 pm"
```

The reference date is Jan 2, 2006 at 3:04:05 PM MST, which can be
remembered as 1 2 3 4 5 6 -7.

I realize that remembering the reference date is not the easy part,
but I think it's easier than remembering all the strftime format
strings

### Supported formats

* Year: 2000 and 00 (but not Ruby's %c for the century)
* Month: January, JANUARY, Jan, JAN, 1, and 01, but not " 1" for space padding
* Day: 2, 02, 002 (for day of year), Monday, MONDAY, Mon, MON, but not " 2" for space padding
* Hour: 15, 3, pm, PM
* Minute: 04
* Second: 05, 05.000 for milliseconds and 05.000000 and 05.000000000
* Time Zone: -7000, -07:00, -07:00:00, MST

### Unsupported Formats

This does not support Ruby's week based formats

### Alternate usage

The slow part of using this gem is generating the format string from
the example, if you want to reuse a format multiple times, you can do so
by creating and reusing an `ExampleFormatter`

```
> ef = ExampleFormatter.new("01/02/06")
> ef.format(Date.today)   => "06/11/18"
> ef.format(Time.now)     => "06/11/18"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/date_by_example. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DateByExample project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/date_by_example/blob/master/CODE_OF_CONDUCT.md).
