# frozen_string_literal: true

require 'byebug'
require_relative 'validation.rb'
require_relative 'inventory.rb'
require_relative 'market.rb'
require_relative 'user_output.rb'
require_relative 'climate.rb'
require_relative 'population.rb'

class LemonadeStand
  attr_reader :inventory, :validation, :user_output, :day_counter, :population
  attr_accessor :climate

  def initialize
    @inventory = Inventory.new
    @validation = Validation.new
    @user_output = UserOutput.new
    @climate = Climate.new
    @day_counter = 1
    @population = Population.new
  end

  def initialize_climate
    climate.set_temperature
  end

  def update_temperature
    climate.update_temperature(5)
  end

  def retrieve_input
    user_input = gets.chomp

    until user_input.match?(/^\d+$/)
      @user_output.invalid_input
      user_input = gets.chomp
    end

    user_input.to_i
  end

  def purchase(item)
    # TODO: implement this!!!
    price = @inventory.get_price(item)
    maximum_items = (@inventory.funds / price).round(2)
    @user_output.purchase_output(price, maximum_items, item)
    quantity = retrieve_input
    until @validation.can_afford?(@inventory.funds, price, quantity)
      @user_output.cant_afford(item, quantity)
      quantity = retrieve_input
    end
    @inventory.purchase(item, quantity)
  end

  def make_lemonade
    maximum_cups = [@inventory.lemons, @inventory.sugar].min
    @user_output.make_lemonade_output(maximum_cups)
    quantity = retrieve_input
    until @validation.can_make_lemonade?(@inventory.lemons, @inventory.sugar, quantity)
      @user_output.cant_make('cups')
      quantity = retrieve_input
    end
    @inventory.make_lemonade(quantity)
  end

  def funds?
    @inventory.funds.positive?
  end

  def set_market_prices
    @user_output.start_of_day_output(@inventory.funds, @inventory.lemons, @inventory.sugar, climate.temperature, @day_counter)
    @inventory.set_lemon_price
    @inventory.set_sugar_price
  end

  def set_lemonade_price
    @user_output.set_lemonade_price_output
    price = retrieve_input
    @inventory.lemonade_price = price
    @user_output.lemonade_confirmation_output(@inventory.cups, price)
    @inventory.get_opening_funds
  end

  def generate_population
    @population.generate_population(climate.temperature)
  end

  def sell_lemonade
    consumers = @population.calculate_population_consumer_ratio(@inventory.lemonade_price)
    @inventory.make_sale(consumers)
    @user_output.end_of_day_output(@day_counter.to_s, @population.population_counter.to_s, consumers)
    @day_counter += 1
  end

  def generate_random_value(min, max, round)
    Random.new.rand(min..max).round(round)
  end

  def calculate_profit
    @user_output.profit_loss_output(@inventory.calculate_profit) # TODO: need to take into account costs. currently just revenue
  end
end
