require_relative '../rspec_helper'
require_relative '../../lib/climate_reference'
require 'ostruct'

RSpec.describe ClimateReference do
  let(:temperature) {70.0}
  let(:humidity) {45.0}
  let(:co_level) {6}
  
  describe 'storing values' do
    it 'stores temperature reference value' do
      climate_reference = ClimateReference.new(temperature: temperature)
      expect(climate_reference.temperature).to eq(temperature)
    end
  
    it 'stores humidity reference value' do
      climate_reference = ClimateReference.new(humidity: humidity)
      expect(climate_reference.humidity).to eq(humidity)
    end
  
    it 'stores co level reference value' do
      climate_reference = ClimateReference.new(co_level: co_level)
      expect(climate_reference.co_level).to eq(co_level)
    end
  end
  
  describe '#hash' do
    it 'returns correct composite hash value' do
      climate_reference = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      expected_hash = temperature.hash ^ humidity.hash ^ co_level.hash
      expect(climate_reference.hash).to eq(expected_hash)
    end

    it 'returns correct composite hash value when climate reference values are all nil' do
      climate_reference = ClimateReference.new
      expected_hash = nil.hash ^ nil.hash ^ nil.hash
      expect(climate_reference.hash).to eq(expected_hash)
    end
  end
  
  describe 'equality' do
    it 'returns true for two equal climate references' do
      climate_reference1 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      climate_reference2 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      expect(climate_reference1).to eq(climate_reference2)
    end
    
    it 'returns true for two equal climate references with all nil values' do
      climate_reference1 = ClimateReference.new
      climate_reference2 = ClimateReference.new
      expect(climate_reference1).to eq(climate_reference2)
    end
    
    it 'returns false for two unequal climate references due to different temperatures' do
      climate_reference1 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      climate_reference2 = ClimateReference.new(
        temperature: temperature + 1.0,
        humidity: humidity,
        co_level: co_level
      )
      expect(climate_reference1).to_not eq(climate_reference2)
    end
    
    it 'returns false for two unequal climate references due to different humidity' do
      climate_reference1 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      climate_reference2 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity + 1.0,
        co_level: co_level
      )
      expect(climate_reference1).to_not eq(climate_reference2)
    end
    
    it 'returns false for two unequal climate references due to different CO level' do
      climate_reference1 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      climate_reference2 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level + 1.0
      )
      expect(climate_reference1).to_not eq(climate_reference2)
    end
  end
  
  describe '#eql?' do
    it 'returns true for two equal climate references' do
      climate_reference1 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      climate_reference2 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      expect(climate_reference1).to eql(climate_reference2)
    end
    
    it 'returns false when comparing a climate reference with an object having the same reference values' do
      climate_reference1 = ClimateReference.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      climate_reference2 = OpenStruct.new(
        temperature: temperature,
        humidity: humidity,
        co_level: co_level
      )
      expect(climate_reference1).to eq(climate_reference2)
      expect(climate_reference1).to_not eql(climate_reference2)
    end
  end
end