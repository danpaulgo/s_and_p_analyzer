require_relative "../../config/environment.rb"
class DisplayData

  def self.display_datapoint(datapoint)
    puts "-"*50
    date = datapoint.date
      # previous_month = Date.new(date.year, date.month-1, date.day)
      # previous_month = Date.new(date.year-1, date.month, date.day)
    puts "Date: #{datapoint.date.strftime('%b %d, %Y')}"
    puts "Price: $#{datapoint.price}"
    puts "Change from #{datapoint.previous_month.strftime('%m/%d/%Y')}: $#{datapoint.monthly_change}"
    puts "Change from #{datapoint.previous_year.strftime('%m/%d/%Y')}: $#{datapoint.yearly_change}"
    puts "-"*50
    nil
  end

  def self.display_points(array)
    array.each do |datapoint|
      self.display_datapoint(datapoint)
    end
  end

  def self.display_all
    self.display_points(DataPoint.all)
  end

  def self.display_yearly(month = 1)
    array = DataPoint.all.select do |point|
      point.date.month == month
    end
    self.display_points(array)
  end

  def self.display_by_year(year)
    array = DataPoint.all.select do |point|
      point.date.year == year
    end
    self.display_points(array)
  end

end