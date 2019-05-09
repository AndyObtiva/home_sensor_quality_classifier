class ClimateReference
  attr_reader :temperature, :humidity, :co_level
  
  def initialize(temperature: nil, humidity: nil, co_level: nil)
    @temperature = temperature
    @humidity = humidity
    @co_level = co_level
  end
  
  def hash
    temperature.hash ^ humidity.hash ^ co_level.hash
  end
  
  def ==(other)
    temperature == other.temperature &&
      humidity == other.humidity &&
      co_level == other.co_level
  end
  
  def eql?(other)
    self.class == other.class &&
      self == other
  end

end