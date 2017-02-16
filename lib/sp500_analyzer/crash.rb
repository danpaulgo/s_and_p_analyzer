require_relative "../../config/environment.rb"

class Crash

  attr_reader :peak, :bottom, :crash_period 
  attr_accessor :recovery_point

  def initialize(peak, bottom)
    @peak = peak
    @bottom = bottom
    @crash_period = bottom.id - peak.id
    set_recovery
  end

  def set_recovery
    @recovery_point = AnalyzeData.find_recovery(peak)
    # @recovery_point = "(Market has not recovered)" if @recovery_point.nil?
  end

end