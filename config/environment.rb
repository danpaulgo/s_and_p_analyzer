require "bundler"
require "nokogiri"
require "open-uri"
require "date"
require "pry"
# Bundler.require

require_relative "../lib/sp500_analyzer/cli.rb"
require_relative "../lib/sp500_analyzer/version.rb"
require_relative "../lib/sp500_analyzer/data_point.rb"
require_relative "../lib/sp500_analyzer/display_data.rb"
require_relative "../lib/sp500_analyzer/scraper.rb"
require_relative "../lib/sp500_analyzer/analyze_data.rb"
require_relative "../lib/sp500_analyzer/crash.rb"
