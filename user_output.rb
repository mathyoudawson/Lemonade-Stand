class UserOutput

  attr_accessor :day_counter
  def initialize
    @day_counter = 0
  end

  def new_day_output(funds, lemons, sugar)
    @day_counter += 1
    puts "\nWelcome to Day #{@day_counter}"
    puts "You currently have $#{funds}, #{lemons} lemons and #{sugar} sugar"
  end

  def purchase_lemons_output(price, maximum_lemons)
    puts "Lemons are currently $#{price}. How many would you like to buy (Maximum: #{maximum_lemons})?"
  end

  def purchase_sugar_output(price, maximum_sugar)
    puts "Sugar is currently $#{price}. How many would you like to buy (Maximum: #{maximum_sugar})?"
  end

  def make_lemonade_output(maximum_cups)
    puts "How many cups of lemonade would you like to make? (Maximum: #{maximum_cups})"
  end

  def set_lemonade_price_output
    puts "How much would you like to charge per cup of lemonade?"
  end

  def lemonade_confirmation_output(cups, price)
    puts "You are selling #{cups} cups at $#{price} each."
  end

  def cant_make(cups)
    puts "Can't make that many #{cups}. Enter new amount: "
  end
  def cant_afford(item)
    puts "Can't afford that #{item}. Enter new amount: "
  end
end
