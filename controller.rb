require 'byebug'

class Inventory

  attr_accessor :funds, :sugar, :lemons, :cups, :lemon_price, :sugar_price, :lemonade_price

  def initialize
    @lemons = 0
    @funds = 5 #in dollars
    @sugar = 0
    @cups = 0
    @market = Market.new
    @lemon_price = 0
  end

  def make_lemonade(quantity)
    @sugar -= quantity
    @lemons -= quantity
    @cups += quantity
  end

  def set_lemon_price
    @lemon_price = @market.calculate_lemon_price
  end

  def set_sugar_price
    @sugar_price = @market.calculate_sugar_price
  end

  def purchase_lemons(quantity)
      @lemons += quantity
      @funds -= @lemon_price * quantity
  end

  def purchase_sugar(quantity)
      @sugar += quantity
      @funds -= @sugar_price * quantity
  end
end

class LemonadeStand
  def initialize
    @inventory = Inventory.new
    @validation = Validation.new
    @day_counter = 0
  end

  def user_output(event)
    case event
    when :play_game
      @day_counter += 1
      puts "\nWelcome to Day #{@day_counter}"
      puts "You currently have $#{@inventory.funds.round(2)}, #{@inventory.lemons} lemons and #{@inventory.sugar} sugar"
    when :purchase_lemons
      maximum_lemons = (@inventory.funds / @inventory.lemon_price).round(2)
      puts "Lemons are currently $#{@inventory.lemon_price}. How many would you like to buy (Maximum: #{maximum_lemons})?"
    when :purchase_sugar
      maximum_sugar = (@inventory.funds / @inventory.sugar_price).round(2)
      puts "Sugar is currently $#{@inventory.sugar_price}. How many would you like to buy (Maximum: #{maximum_sugar})?"
    when :make_lemonade
      maximum_cups = [@inventory.lemons, @inventory.sugar].min
      puts "How many cups of lemonade would you like to make? (Maximum: #{maximum_cups})"
    when :set_lemonade_price
      puts "How much would you like to charge per cup of lemonade?"
    else
      puts "Invalid Method"
    end
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
    user_output(__method__)
    quantity = get_input
    while !@validation.can_afford?(@inventory.funds, @inventory.lemon_price, quantity)
      puts "Can't afford that many lemons. Enter new amount: "
      quantity = get_input
    end
    @inventory.purchase_lemons(quantity)
  end

  def purchase_sugar
    user_output(__method__)
    quantity = get_input
    while !@validation.can_afford?(@inventory.funds, @inventory.sugar_price, quantity)
      puts "Can't afford that much sugar. Enter new amount: "
      quantity = get_input
    end
    @inventory.purchase_sugar(quantity)
  end

  def make_lemonade
    user_output(__method__)
    quantity = get_input
    while !@validation.can_make_lemonade?(@inventory.lemons, @inventory.sugar, quantity)
      puts "Can't make that many cups. Enter new amount: "
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
    user_output(__method__)
    price = get_input
    @inventory.lemonade_price = price
    puts "You are selling #{@inventory.cups} cups at $#{price} each."
  end

  def play_game
    while user_has_funds do #TODO: extrapolate to own boolean method
      user_output(__method__)
      set_market_prices
      purchase_lemons
      purchase_sugar
      make_lemonade
      set_lemonade_price
    end
  end
end

class Market

  def calculate_lemon_price
    Random.new.rand(0.25..0.50).round(2) #returns random number between 0.25-0.5 rounded to the nearest 2dp
  end

  def calculate_sugar_price
    Random.new.rand(0.02..0.05).round(2) #returns random number between 0.02-0.05 rounded to the nearest 2dp
  end
end

class Validation
  def can_afford?(funds, price, quantity)
    if price * quantity < funds
      true
    else
      false
    end
  end

  def can_make_lemonade?(lemons, sugar, quantity)
    if quantity <= [lemons, sugar].min
      true
    else
      false
    end
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
