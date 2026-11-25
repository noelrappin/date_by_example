## Version 0.2.0 11/24/2026

* Requires Ruby 3.4 or later
* Adds word-style formatting with `{{Token}}` syntax, e.g. `{{Mon}} {{Date:1}}, {{Year}}`
* Adds `by_example_go` and `by_example_word` to choose a style explicitly;
  `by_example` uses word style whenever the format contains `{{`
* BREAKING: `ExampleFormatter` is now abstract; use `ExampleFormatter.for`,
  `GoFormatter.new`, or `WordFormatter.new`. `FORMATS` moved to `GoFormatter`
* BREAKING: Go-style `3` is now unpadded (`%-l`) as documented; it was space-padded
* Fixes Go-style `.000000000` nanoseconds
* Fixes Go-style zone `-0700` (was the typo `-7000`)
* Adds Go-style `_2` and `__2` for space-padded day and day of year
* A literal `%` in a format no longer reaches strftime

## Version 0.1.1 6/22/2018

* Adds "%l" for single digit hours
