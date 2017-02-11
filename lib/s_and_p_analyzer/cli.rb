require_relative "../../config/environment.rb"

class CLI

  def call
    Scraper.array_to_datapoints
    DataPoint.set_historical_max
    start
  end

  def menu
    puts "1. See all prices by month"
    puts "2. See all prices by year"
    puts "3. See all prices for single year"
    puts "4. Extended info for single date"
    puts "5. Maximum prices by year"
    puts "6. Market crash info"
    puts "7. Compare two dates"
  end

  def start
    puts "Welcome to S&P Analyzer. Please choose from the following menu options:"
    go = "y"
    until go.downcase == "n"
      menu
      input = ""
      until input.downcase == "q" || (input.to_i >= 1 && input.to_i <= 7)
        print "Item No. (or \"q\" to exit): "
        input = gets.strip
      end
      case input
      when "1"
        DisplayData.display_all
      when "2"
        DisplayData.display_yearly
      when "3"
        DisplayData.display_by_year
      when "4"
        DisplayData.extended_info
      when "5"
        puts "code 5"
      when "6"
        puts "code 6"
      when "7"
        puts "code 7"  
      when "q"
        go = "n"
      end
      if go != "n"
        print "Would you like to complete another action? (y/n) "
        go = gets.strip
      end
    end
  end
end