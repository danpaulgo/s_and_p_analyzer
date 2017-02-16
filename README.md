# S&P 500 Analyzer

This gem is created to analyze all monthly pricing data from the S&P 500. Each datapoint is pulled from multpl.com's "S&P 500 Historical Prices by Month" chart which includes opening prices from the first of each month as early as January, 1871. Since the S&P 500 did not come into existence until 1957, all price data before this point are estimates of what a similar index would project given historical market conditions. These estimates come from the research and writing of Robert Shiller, presented in his book "Irrational Exuberance." Using this data, users are able to analyze and compare market conditions and pricing over long periods of time. 

## Installation

Install using gem command: `gem install s_and_p_analyzer`

## Usage

After installation, run `sp500_analyzer` and choose from one of the seven menu options

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danpaulgo/s_and_p_analyzer.

