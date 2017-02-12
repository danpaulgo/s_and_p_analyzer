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
    puts "\nWelcome to S&P Analyzer. Please choose from the following menu options:"
    puts "\n"
    go = "y"
    until go.downcase == "n"
      menu
      input = ""
      until input.downcase == "q" || (input.to_i >= 1 && input.to_i <= 7)
        print "\nItem No. (or \"q\" to exit): "
        input = gets.strip
      end
      puts "\n"
      case input
      when "1"
        DisplayData.display_points(DataPoint.all)
      when "2"
        DisplayData.display_yearly
      when "3"
        valid_year = false
        until valid_year == true
          print "Enter year: "
          year = gets.strip.to_i
          valid_year = DisplayData.validate_year(year)
        end
        DisplayData.display_by_year(year)
      when "4"
        valid_date = false
        until valid_date == true
          print "Enter date (mm/yyyy): "
          date = gets.strip
          valid_date = DisplayData.validate_date(date)
        end
        DisplayData.extended_info(date)
      when "5"
        DisplayData.display_max_by_year
      when "6"
        DisplayData.display_market_crash_info
      when "7"
        valid_dates = [false,false]
        until valid_dates[0] == true
          print "Enter first date (mm/yyyy): "
          date_1 = gets.strip
          valid_dates[0] = DisplayData.validate_date(date_1)
        end
        until valid_dates[1] == true
          print "Enter second date (mm/yyyy): "
          date_2 = gets.strip
          valid_dates[1] = DisplayData.validate_date(date_2)
        end
        DisplayData.display_comparison_info(date_1, date_2)
      when "q"
        go = "n"
      end
      if go != "n"
        print "\nWould you like to complete another action? (y/n) "
        go = gets.strip
        puts "\n"
      end
    end
  end
end