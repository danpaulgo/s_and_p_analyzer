require_relative "../../config/environment.rb"
class DisplayData

  def self.display_price(price)
    sprintf('%.2f', price)
  end

  def self.display_datapoint(datapoint)
    # date = datapoint.date
      # previous_month = Date.new(date.year, date.month-1, date.day)
      # previous_month = Date.new(date.year-1, date.month, date.day)
    puts "Date: #{datapoint.date.strftime('%b-%d-%Y')}     Price: $#{display_price(datapoint.price)}"
    # puts "Change from #{datapoint.previous_month.strftime('%m/%d/%Y')}: $#{datapoint.monthly_change}"
    # puts "Change from #{datapoint.previous_year.strftime('%m/%d/%Y')}: $#{datapoint.yearly_change}"
    puts "-"*40
    nil
  end

  def self.extended_info
    datapoint = DataPoint.find_by_date
    puts "Date: #{datapoint.date.strftime('%B %d, %Y')}"
    puts "Price: $#{display_price(datapoint.price)}"
    puts "Change over previous month: $#{datapoint.monthly_change}"
    puts "Change over previous year: $#{datapoint.yearly_change}"
    puts "Historical maximum(#{datapoint.historical_max.date.strftime('%m/%d/%Y')}): $#{display_price(datapoint.historical_max.price)}"
  end

  def self.display_points(array)
    puts "-"*40
    array.each do |datapoint|
      display_datapoint(datapoint)
    end
  end

  def self.display_yearly
    array = DataPoint.all.select do |point|
      point.date.month == 1
    end
    self.display_points(array)
  end

  def self.display_by_year
    year = 0
      until year >= 1871 && year <= DataPoint.all.last.date.year
        print "Enter year: "
        year = gets.strip.to_i
      end
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
      display_datapoint(AnalyzeData.annual_max(year.to_i))
    end
  end
end