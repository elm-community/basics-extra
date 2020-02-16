# Functions to supplement Basics

[![Build Status](https://travis-ci.org/elm-community/basics-extra.svg?branch=master)](https://travis-ci.org/elm-community/basics-extra)

Package for functions that feel like they should be included in [Basics](https://package.elm-lang.org/packages/elm/core/latest/Basics) but for one reason or another are not.

Feedback and contributions are very welcome.

## Tests

This package uses [elm-test](https://github.com/elm-explorations/test) and [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).

## Contributing

Pull requests are welcome. You can expect some kind of response within 1 week.

If you are proposing a new function be added, please adhere to the following:

1. Include [documentation](http://package.elm-lang.org/help/documentation-format) and make sure your documentation has a code snippet demonstrating what the function does. We use [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples) in our continuous integration setup to ensure the documentation examples are correct, so please take advantage of that.
2. Provide a detailed use case where your new function would be useful. Also, compare your new function to the best possible implementation that doesn't include use your function.
3. Add tests to `Tests/Tests.elm`

If you are improving existing functions please demonstrate the performance gains in something like [Ellie](https://ellie-app.com/) and by using a benchmark library like [this one](http://package.elm-lang.org/packages/BrianHicks/elm-benchmark/latest).
