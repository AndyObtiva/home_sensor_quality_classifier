require_relative '../../rspec_helper'
require_relative '../../../lib/sensor/carbon_monoxide_detector_sensor'

RSpec.describe Sensor::CarbonMonoxideDetectorSensor do
  let(:name) { "mon-1" }
  let(:readings) {
    [
      { date: DateTime.new(2007,4, 5, 22, 4), value: 5 },
      { date: DateTime.new(2007,4, 5, 22, 5), value: 7 },
      { date: DateTime.new(2007,4, 5, 22, 6), value: 9 },
    ]
  }
  
  subject { 
    Sensor::CarbonMonoxideDetectorSensor.new(
      name: name,
      readings: readings
    )
  }
  
  it 'returns name' do
    expect(subject.name).to eq(name)
  end
  
  it 'returns readings' do
    expect(subject.readings).to eq(readings)
  end
end