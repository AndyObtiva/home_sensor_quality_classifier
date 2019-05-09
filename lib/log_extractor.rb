class LogExtractor
  def initialize(log_contents_str)
    @log_contents_str = log_contents_str
  end
  
  def extract_climate_reference
    temperature, humidity, co_level = climate_reference_line.split(' ').drop(1).map(&:to_f)
    ClimateReference.new(
      temperature: temperature,
      humidity: humidity,
      co_level: co_level
    )
  end
  
  private
  
  def climate_reference_line
    @climate_reference_line ||= @log_contents_str.split("\n").first
  end
end