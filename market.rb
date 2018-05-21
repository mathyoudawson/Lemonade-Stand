class Market
  MARKET_ROUND = 2
  attr_accessor :lemon_price, :sugar_price, :generate

  def initialize(generate: RandomGenerator::Generate.new)
    @generate = generate
  end

  def calculate_lemon_price
    # Random.new.rand(0.25..0.50).round(2) # returns random number between 0.25-0.5 rounded to the nearest 2dp
    @lemon_price = calculate_price(min, max)
  end

  def calculate_sugar_price
    Random.new.rand(0.02..0.05).round(2) # returns random number between 0.02-0.05 rounded to the nearest 2dp
  end

  def set_prices(ingredient)
    ingredient = calculate
  end

  def calculate_price(min, max)
    generate.random_value(min, max, MARKET_ROUND)
  end
end
