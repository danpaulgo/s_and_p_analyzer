require "bundler"
require "nokogiri"
require "open-uri"
require "date"
require "pry"
Bundler.require

require_relative "../lib/s_and_p_analyzer/cli.rb"
require_relative "../lib/s_and_p_analyzer/version.rb"
require_relative "../lib/s_and_p_analyzer/data_point.rb"
require_relative "../lib/s_and_p_analyzer/display_data.rb"
require_relative "../lib/s_and_p_analyzer/scraper.rb"
require_relative "../lib/s_and_p_analyzer/analyze_data.rb"
require_relative "../lib/s_and_p_analyzer/crash.rb"
