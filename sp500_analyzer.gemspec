# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sp500_analyzer/version'

Gem::Specification.new do |spec|
  spec.name          = "sp500_analyzer"
  spec.version       = SP500Analyzer::VERSION
  spec.authors       = ["Daniel Goldberg"]
  spec.email         = ["danpaulgo@aol.com"]
  spec.summary       = "This gem allows for basic analyzation of stock market conditions using S&P 500 historical price data."
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/danpaulgo/s_and_p_analyzer"
  spec.require_paths = ["lib"]
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables << "sp500_analyzer"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", "~> 1.0"
  spec.add_development_dependency "pry", "~> 0"
end
