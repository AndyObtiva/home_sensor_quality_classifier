require_relative '../rspec_helper'
require_relative '../../lib/sensor_evaluator'

RSpec.describe SensorEvaluator do
  # TODO refine tests further
  it 'works' do
    output = SensorEvaluator.new('whatever').classify_sensors
    expected_value = {
      "temp-1": "precise",
      "temp-2": "ultra precise",
      "hum-1": "keep",
      "hum-2": "discard",
      "mon-1": "keep",
      "mon-2": "discard"
    }
    expect(output).to eq(expected_value)
  end
end