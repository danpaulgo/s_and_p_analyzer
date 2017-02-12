require_relative "../../config/environment.rb"
class DisplayData

  def self.display_price(price)
    if price > 0
      price_string = "$" + sprintf('%.2f', price)
    else
      price_string = "-$" + sprintf('%.2f', price.abs)
    end
    price_string
  end

  def self.validate_date(date)
    valid = false
    date_array = date.split("/")
    valid = true if date_array[0].to_i >= 1 && date_array[0].to_i <= 12 && date_array[1].to_i >= 1871 && date_array[1].to_i <= DataPoint.all.last.date.year
    valid
  end

  def self.validate_year(year)
    valid = false
    valid = true if year >= 1871 && year <= DataPoint.all.last.date.year
    valid
  end

  def self.display_datapoint(datapoint)
    "Date: #{datapoint.date.strftime('%b-%d-%Y')}     Price: #{display_price(datapoint.price)}"
  end

  def self.extended_info(date)
    datapoint = DataPoint.find_by_date(date)
    puts "-"*40
    puts "Date: #{datapoint.date.strftime('%B %d, %Y')}"
    puts "Price: #{display_price(datapoint.price)}"
    puts "Change over previous month: #{display_price(datapoint.monthly_change)}"
    puts "Change over previous year: #{display_price(datapoint.yearly_change)}"
    puts "Historical maximum(#{datapoint.historical_max.date.strftime('%m/%d/%Y')}): #{display_price(datapoint.historical_max.price)}"
    puts "-"*40
  end

  def self.display_points(array)
    puts "-"*40
    array.each do |datapoint|
      puts display_datapoint(datapoint)
      puts "-"*40
    end
  end

  def self.display_yearly
    array = DataPoint.all.select do |point|
      point.date.month == 1
    end
    self.display_points(array)
  end

  def self.display_by_year(year)
    array = DataPoint.all.select do |point|
      point.date.year == year
    end
    self.display_points(array)
  end

  def self.display_max_by_year
    year = ""
    until year == "all" || (year.to_i >= 1871 && year.to_i <= DataPoint.all.last.date.year)
      print "Enter year (or \"all\" to see maximums for all years): "
      year = gets.strip
    end
    if year == "all"
      all_years = (DataPoint.all.first.date.year..DataPoint.all.last.date.year).to_a
      maximums = all_years.map do |year|
        AnalyzeData.annual_max(year)
      end
      display_points(maximums)
    else
      puts "-"*40
      puts display_datapoint(AnalyzeData.annual_max(year.to_i))
      puts "-"*40
    end
  end

  def self.display_market_crash_info

  end

  def self.display_comparison_info(date_1, date_2)
    datapoint1 = DataPoint.find_by_date(date_1)
    datapoint2 = DataPoint.find_by_date(date_2)
    if datapoint1.date > datapoint2.date
      datapoint1 = DataPoint.find_by_date(date_2)
      datapoint2 = DataPoint.find_by_date(date_1)
    end
    difference = datapoint2.price - datapoint1.price
    string_difference = display_price(difference)
    high = AnalyzeData.max_within_period(datapoint1,datapoint2)
    low = AnalyzeData.min_within_period(datapoint1,datapoint2)
    puts "-"*50
    puts "1. " + display_datapoint(datapoint1)
    puts "2. " + display_datapoint(datapoint2)
    puts "\nChange in price between #{datapoint1.date.strftime('%m/%d/%Y')} and #{datapoint2.date.strftime('%m/%d/%Y')}:" 
    puts "#{string_difference}"
    puts "\nHighest point between #{datapoint1.date.strftime('%m/%d/%Y')} and #{datapoint2.date.strftime('%m/%d/%Y')}:"
    puts display_datapoint(high)
    puts "\nLowest point between #{datapoint1.date.strftime('%m/%d/%Y')} and #{datapoint2.date.strftime('%m/%d/%Y')}:"
    puts display_datapoint(low)
    puts "-"*50
  end

end