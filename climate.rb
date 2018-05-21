require_relative 'random_generator.rb'
require 'byebug'

class Climate
  TEMP_MIN = 15
  TEMP_MAX = 35
  TEMP_ROUND = 1
  attr_accessor :temperature, :generate

  def initialize(generate: RandomGenerator::Generate.new)
    @generate = generate
  end

  def set_temperature
    @temperature = generate.random_value(TEMP_MIN, TEMP_MAX, TEMP_ROUND)
  end

  def update_temperature(range)
    @temperature = generate.random_value(temperature - range, temperature + range, TEMP_ROUND)
  end
end
