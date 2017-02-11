 require_relative "../../config/environment.rb"

class DataPoint

  @@all = []

  attr_accessor :id, :date, :price, :monthly_change, :yearly_change, :historical_max, :max_date

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def previous_month
    year = date.year
    month = date.month
    day = date.day
    if month == 1
      prev_month = 12
    else
      prev_month = month-1
    end
    Date.new(year, prev_month, day)
  end

  def previous_year
    year = date.year
    month = date.month
    day = date.day
    prev_year = year-1
    Date.new(year-1, month, day)
  end

  def self.set_historical_max
    all.each_with_index do |datapoint, index|
      loop_index = 0
      maximum = datapoint
      until loop_index >= index
        if all[loop_index].price >= maximum.price
          maximum = all[loop_index]
        end
        loop_index += 1
      end
      datapoint.historical_max = maximum
    end
    nil
  end

  def self.find_by_year(year)
    all.select do |datapoint|
      datapoint.date.year == year
    end
  end

  def self.find_by_date
    month = 0
    year = 0
    until month >= 1 && month <= 12 && year >= 1871 && year.to_s.split("").length == 4
      print "Enter Date(mm/yyyy): "
      date = gets.strip
      month = date.split("/")[0].to_i
      year = date.split("/")[1].to_i
    end
    all.detect do |datapoint|
      datapoint.date.month == month && datapoint.date.year == year
    end
  end

end