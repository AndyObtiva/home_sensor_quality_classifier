require 'date'
require_relative '../sensor'

class Sensor::CarbonMonoxideDetectorSensor < Sensor
  attr_reader :name, :readings
  
  def initialize(name: nil, readings: nil)
    @name = name
    @readings = readings
  end
end