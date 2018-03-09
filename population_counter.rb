class Population
  attr_accessor :population_counter
  def generate_population(temperature)
    @population_counter = (temperature * temperature) / 10
  end

  def calculate_population_consumer_ratio(price)
    ratio = (10 - price) * 0.1
    consumer_ratio = @population_counter * ratio
    ratio = 0 if ratio < 0
  end
end
