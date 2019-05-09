class SensorEvaluator
  def initialize(log_contents_str)
    @log_contents_str = log_contents_str
    #TODO use LogExtractor and implement evaluation logic
  end
  
  def classify_sensors
    {
      "temp-1": "precise",
      "temp-2": "ultra precise",
      "hum-1": "keep",
      "hum-2": "discard",
      "mon-1": "keep",
      "mon-2": "discard"
    }
  end
end