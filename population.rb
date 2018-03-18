# frozen_string_literal: true

class Population
  attr_accessor :population_counter
  def generate_population(temperature)
    @population_counter = (temperature * temperature) / 10
  end

  def calculate_population_consumer_ratio(price)
    ratio = @population_counter * (10 - price) * 0.1
    ratio.negative? ? 0 : ratio
  end
end
