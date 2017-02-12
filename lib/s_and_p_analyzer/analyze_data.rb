require_relative "../../config/environment.rb"

class AnalyzeData

  def self.annual_max(year)
    array = DataPoint.find_by_year(year)
    array.max_by do |datapoint|
      datapoint.price
    end
  end

  def self.annual_min(year)
    array = DataPoint.find_by_year(year)
    array.min_by do |datapoint|
      datapoint.price
    end
  end

  def self.market_crashes(fraction, time_in_months)
    crashes = []
    DataPoint.all.each do |datapoint|
      # binding.pry
      crashes << datapoint if datapoint.price <= datapoint.historical_max.price * fraction && (datapoint.id - datapoint.historical_max.id <= time_in_months)
    end
    crashes
  end

  def self.market_peaks(fraction, time_in_months)
    peaks = []
    market_crashes(fraction, time_in_months).each do |crash|
      DataPoint.all.each do |datapoint|
        peaks << datapoint if datapoint.price == crash.historical_max.price && datapoint.price == datapoint.historical_max.price && !peaks.include?(datapoint)
      end
    end
    peaks
  end

  def self.market_crash_mins(fraction, time_in_months)
    peaks = market_peaks(fraction, time_in_months)
    mins = []
    peaks.each_with_index do |peak, index|
      if peaks[index+1].nil?
        peak_2 = DataPoint.all.last
      else
        peak_2 = peaks[index+1]
      end
      mins << min_within_period(peak, peak_2)
    end
    mins
  end

  def self.price_difference(datapoint_1, datapoint_2)
    datapoint_1.price - datapoint_2.price
  end

  def self.timeframe(datapoint_1, datapoint_2)
    data_spread = []
    range = [datapoint_1.id, datapoint_2.id]
    loop_id = range.min
    while loop_id <= range.max
      data_spread << DataPoint.all[loop_id]
      loop_id += 1
    end
    data_spread
  end

  def self.max_within_period(datapoint_1, datapoint_2)
    timeframe(datapoint_1,datapoint_2).max_by do |datapoint|
      datapoint.price
    end
  end

  def self.min_within_period(datapoint_1, datapoint_2)
    timeframe(datapoint_1,datapoint_2).min_by do |datapoint|
      datapoint.price
    end
  end

end