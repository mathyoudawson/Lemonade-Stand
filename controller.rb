require 'byebug'

class Inventory

  attr_accessor :funds, :sugar, :lemons, :cups, :lemon_price, :sugar_price

  def initialize
    @lemons = 0
    @funds = 5 #in dollars
    @sugar = 0
    @cups = 0
    @market_instance = Market.new
  end

  def make_cups(number_of_cups)
    sugar -= number_of_cups
    lemons -= number_of_cups
    cups += number_of_cups
  end

  def set_lemon_price
    @lemon_price = @market_instance.calculate_lemon_price
  end

  def purchase_lemons(quantity)
    #byebug
    if @lemon_price * quantity.to_i < @funds
      @lemons += quantity
      @funds -= (@lemon_price * quantity).round(2)
      puts "PL = " + @funds.to_s
    else
      puts "Can't afford that many lemons"
    end
  end

  def set_sugar_price
    @sugar_price = @market_instance.calculate_sugar_price
  end

  def purchase_sugar(quantity)
    if @sugar_price * quantity.to_i < @funds
      @sugar += quantity
      @funds -= (@sugar_price * quantity).round(2)
      puts "PS = " + @funds.to_s
    else
      puts "Can't afford that much sugar"
    end
  end
end

class LemonadeStand
  def initialize
    @inventory_instance = Inventory.new
    @day_counter = 0
  end

  def user_output(event)
    case event
    when :play_game
      @day_counter += 1
      puts "\nWelcome to Day #{@day_counter}"
      puts "You currently have $#{@inventory_instance.funds}, #{@inventory_instance.lemons} lemons and #{@inventory_instance.sugar} sugar"
    when :purchase_lemons
      maximum_lemons = (@inventory_instance.funds / @inventory_instance.lemon_price).round(2)
      puts "Lemons are currently $#{@inventory_instance.lemon_price}. How many would you like to buy (Maximum #{maximum_lemons})?"
    when :purchase_sugar
      maximum_sugar = (@inventory_instance.funds / @inventory_instance.sugar_price).round(2)
      puts "Sugar is currently $#{@inventory_instance.sugar_price}. How many would you like to buy (Maximum #{maximum_sugar})?"
    else
      puts "Invalid Method"
    end
  end

  def validate_user_input
       get_input unless @user_input.match?(/^\d+$/)
       @user_input = @user_input.to_i
  end

  def get_input
    @user_input = gets.chomp
    validate_user_input
  end

  def purchase_lemons
    @inventory_instance.set_lemon_price
    user_output(__method__)
    get_input
    @inventory_instance.purchase_lemons(@user_input)
  end

  def purchase_sugar
    @inventory_instance.set_sugar_price
    user_output(__method__)
    get_input
    @inventory_instance.purchase_sugar(@user_input)
  end

  def make_lemonade
    puts "making"
  end

  def play_game
    while @inventory_instance.funds > 0 do
      user_output(__method__)
      purchase_lemons
      purchase_sugar
      make_lemonade
    end
  end
end

class Market
  def calculate_lemon_price
    @lemon_price = Random.new.rand(0.25..0.50).round(2) #returns random number between 0.25-0.5 rounded to the nearest 2dp
  end

  def calculate_sugar_price
    @sugar_price = Random.new.rand(0.02..0.05).round(2) #returns random number between 0.02-0.05 rounded to the nearest 2dp
  end
end

game_instance = LemonadeStand.new
game_instance.play_game


#Start of day (Initialize)

#You start the game with $5, 0 lemons, 0 sugar, and 0 cups of lemonade
#while the user has funds
#buy lemons (25-50 cents each)
#buy sugar (2-5 cents per unit)
#Make some cups of lemonade (user decides how many) - 1 sugar and 1 lemon to make
#set price for lemonade

#Day plays out

#Temperature for day selected (relative to previous day)
#Number of people who walk by stand is based on Temperature
#Number of cups sold is based on people + price
#Any cups not sold are discarded

#End of Day

#Show profit/loss

# Classes
#
# Inventory: holds lemon + sugar inventory + $ balance + lemonade made
# Day: simulates the day
# Lifecycle: holds multiple days
# PopulationCounter: works out how many people walk past
# Climate: works out how hot the day is based on the last one
# Market: calculates lemon + sugar prices
