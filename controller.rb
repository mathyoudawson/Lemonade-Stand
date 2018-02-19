class Inventory
  attr_accessor :funds, :sugar, :lemons, :cups
  def initialize
    @lemons = 0
    @funds = 5 #in dollars
    @sugar = 0
    @cups = 0
  end
  def make_cups(number_of_cups)
    sugar -= number_of_cups
    lemons -= number_of_cups
    cups += number_of_cups
  end
end

class LemonadeStand
  def initialize
    puts "working"
    @inventory_instance = Inventory.new
  end

  def play_game
    while @inventory_instance.funds > 0 do
      puts "New Day"
    end
  end
end

class Market
  def calculate_lemon_price
    @lemon_price = Random.new.rand(0.25..0.50)
  end

  def calculate_sugar_price
    @sugar_price = Random.new.rand(0.02..0.05)
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
