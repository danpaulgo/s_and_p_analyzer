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
      loop_id = datapoint.id
      valid_crash = false
      until loop_id + time_in_months < datapoint.id || loop_id < 0
        valid_crash = true if datapoint.price <= DataPoint.all[loop_id].price * fraction
        loop_id -= 1
      end
      crashes << datapoint if valid_crash
    end
    crashes
  end

  def self.market_peaks(fraction, time_in_months)
    peaks = []
    market_crashes(fraction, time_in_months).each do |crash|
      peaks << crash.historical_max if !peaks.include?(crash.historical_max)
    end
    peaks
  end

  def self.find_recovery(datapoint)
    loop_id = datapoint.id + 1
    recovered = false
    until recovered == true || loop_id > DataPoint.all.count
      if DataPoint.all[loop_id].price >= datapoint.price
        recovered = true
        recovery_point = DataPoint.all[loop_id]
      end
      loop_id += 1
    end
    recovery_point
  end

  def self.market_crash_mins(fraction, time_in_months)
    peaks = market_peaks(fraction, time_in_months)
    mins = []
    peaks.each do |peak|
      mins << min_within_period(peak, find_recovery(peak))
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