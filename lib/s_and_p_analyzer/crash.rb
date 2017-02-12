require_relative "../../config/environment.rb"

class Crash

  attr_reader :peak, :bottom, :crash_period 
  attr_accessor :recovery_period

  def initialize(peak, bottom)
    @peak = peak
    @bottom = bottom
    @crash_period = bottom_id - peak_id
  end

  def find_recovery
    
  end

end