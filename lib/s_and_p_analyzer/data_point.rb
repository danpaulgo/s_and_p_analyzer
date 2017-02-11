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
  end

  def self.annual_max
    annual_max_array = []
    years = []
    self.all.each do |point|
      years << point.date.year if !years.include?(point.date.year)
    end
    binding.pry
    years.each do |year|
      yearly_array = []
      self.all.each do |point|
        yearly_array << point if point.date.year == year
      end
      annual_max_price = 0
      yearly_array.each do |month|
        if month.price > annual_max_price
          annual_max_price = month.price
          annual_max = month
        end
      end
      annual_max_array << annual_max
    end
    annual_max_array
  end

  

end