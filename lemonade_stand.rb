require 'byebug'
require_relative 'validation.rb'
require_relative 'inventory.rb'
require_relative 'market.rb'
require_relative 'user_output.rb'
require_relative 'climate.rb'
require_relative 'population_counter.rb'

class LemonadeStand
  def initialize
    @inventory = Inventory.new
    @validation = Validation.new
    @user_output = UserOutput.new
    @climate = Climate.new
    @temperature = @climate.generate_initial_temperature
    @day_counter = 0
    @population = Population.new
  end

  def validate_user_input(input)
    get_input unless input.match?(/^\d+$/)
    input.to_i
  end

  def get_input
    user_input = gets.chomp
    validate_user_input(user_input)
  end

  def purchase_lemons
    maximum_lemons = (@inventory.funds / @inventory.lemon_price).round(2)
    @user_output.purchase_lemons_output(@inventory.lemon_price, maximum_lemons)
    quantity = get_input
    until @validation.can_afford?(@inventory.funds, @inventory.lemon_price, quantity)
      @user_output.cant_afford('many lemons')
      quantity = get_input
    end
    @inventory.purchase_lemons(quantity)
  end

  def purchase_sugar
    maximum_sugar = (@inventory.funds / @inventory.sugar_price).round(2)
    @user_output.purchase_sugar_output(@inventory.sugar_price, maximum_sugar)
    quantity = get_input
    until @validation.can_afford?(@inventory.funds, @inventory.sugar_price, quantity)
      @user_output.cant_afford('much sugar')
      quantity = get_input
    end
    @inventory.purchase_sugar(quantity)
  end

  def make_lemonade
    maximum_cups = [@inventory.lemons, @inventory.sugar].min
    @user_output.make_lemonade_output(maximum_cups)
    quantity = get_input
    until @validation.can_make_lemonade?(@inventory.lemons, @inventory.sugar, quantity)
      @user_output.cant_make('cups')
      quantity = get_input
    end
    @inventory.make_lemonade(quantity)
  end

  def user_has_funds
    @inventory.funds > 0
  end

  def set_market_prices
    @inventory.set_lemon_price
    @inventory.set_sugar_price
  end

  def set_lemonade_price
    @user_output.set_lemonade_price_output
    price = get_input
    @inventory.lemonade_price = price
    @user_output.lemonade_confirmation_output(@inventory.cups, price)
  end

  def update_temperature
    @climate.generate_new_temperature(@temperature)
  end

  def generate_population
    @population.generate_population(@temperature)
  end

  def sell_lemonade
    @population.calculate_population_consumer_ratio(@inventory.lemonade_price)
  end

  def play_game
    while user_has_funds # TODO: extrapolate to own boolean method
      @user_output.new_day_output(@inventory.funds, @inventory.lemons, @inventory.sugar, @climate.temperature)
      set_market_prices
      purchase_lemons
      purchase_sugar
      make_lemonade
      set_lemonade_price
      generate_population
      puts 'Population for Day: ' + @day_counter.to_s + ' is ' + @population.population_counter.to_s
      puts "Temperature: #{@climate.temperature} degrees"
      update_temperature
      puts "Updated temperature: #{@climate.temperature}"
      sell_lemonade
    end
  end
end

game_instance = LemonadeStand.new
game_instance.play_game

@inventory.item_price
@inventory.send("#{item}_price".to_sym)

# Start of day (Initialize)

# You start the game with $5, 0 lemons, 0 sugar, and 0 cups of lemonade
# while the user has funds
# buy lemons (25-50 cents each)
# buy sugar (2-5 cents per unit)
# Make some cups of lemonade (user decides how many) - 1 sugar and 1 lemon to make
# set price for lemonade

# Day plays out

# Temperature for day selected (relative to previous day)
# Number of people who walk by stand is based on Temperature
# Number of cups sold is based on people + price
# Any cups not sold are discarded

# End of Day

# Show profit/loss

# Classes
#
# Inventory: holds lemon + sugar inventory + $ balance + lemonade made
# Day: simulates the day
# Lifecycle: holds multiple days
# PopulationCounter: works out how many people walk past
# Climate: works out how hot the day is based on the last one
# Market: calculates lemon + sugar prices
