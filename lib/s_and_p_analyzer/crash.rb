require_relative "../../config/environment.rb"

class Crash

  attr_reader :peak, :bottom, :crash_period 
  attr_accessor :recovery_point

  def initialize(peak, bottom)
    @peak = peak
    @bottom = bottom
    @crash_period = bottom.id - peak.id
    find_recovery
  end

  def find_recovery
    loop_id = bottom.id
    recovered = false
    until recovered == true || loop_id > DataPoint.all.count
      if DataPoint.all[loop_id].price >= peak.price
        recovered = true
        @recovery_point = DataPoint.all[loop_id]
      end
      loop_id += 1
    end
    @recovery_point = "(Market has not recovered)" if @recovery_point.nil?
  end

end