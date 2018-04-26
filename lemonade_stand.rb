# frozen_string_literal: true

require 'byebug'
require_relative 'validation.rb'
require_relative 'inventory.rb'
require_relative 'market.rb'
require_relative 'user_output.rb'
require_relative 'climate.rb'
require_relative 'population.rb'

class LemonadeStand
  def initialize
    @inventory = Inventory.new
    @validation = Validation.new
    @user_output = UserOutput.new
    @climate = Climate.new
    @temperature = @climate.generate_initial_temperature
    @day_counter = 1
    @population = Population.new
  end

  # def validate_user_input(user_input)
  #   until user_input.match?(/^\d+$/)
  #     puts "enter valid input"
  #     user_input = retrieve_input
  #   end

  #   user_input
  # end

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

  def purchase_shits(ingredient) end

  def purchase_lemons
    maximum_lemons = (@inventory.funds / @inventory.lemon_price).round(2)
    @user_output.purchase_lemons_output(@inventory.lemon_price, maximum_lemons)
    quantity = retrieve_input
    until @validation.can_afford?(@inventory.funds, @inventory.lemon_price, quantity)
      @user_output.cant_afford('many lemons')
      quantity = retrieve_input
    end
    @inventory.purchase_lemons(quantity)
  end

  def purchase_sugar
    maximum_sugar = (@inventory.funds / @inventory.sugar_price).round(2)
    @user_output.purchase_sugar_output(@inventory.sugar_price, maximum_sugar)
    quantity = retrieve_input
    until @validation.can_afford?(@inventory.funds, @inventory.sugar_price, quantity)
      @user_output.cant_afford('much sugar')
      quantity = retrieve_input
    end
    @inventory.purchase_sugar(quantity)
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
    @user_output.start_of_day_output(@inventory.funds, @inventory.lemons, @inventory.sugar, @climate.temperature, @day_counter)
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

  def update_temperature
    @climate.generate_new_temperature(@temperature)
  end

  def generate_population
    @population.generate_population(@temperature)
  end

  def sell_lemonade
    consumers = @population.calculate_population_consumer_ratio(@inventory.lemonade_price)
    @inventory.make_sale(consumers)
    @user_output.end_of_day_output(@day_counter.to_s, @population.population_counter.to_s, consumers)
    @day_counter += 1
  end

  def calculate_profit
    @user_output.profit_loss_output(@inventory.calculate_profit) # TODO: need to take into account costs. currently just revenue
  end
end
