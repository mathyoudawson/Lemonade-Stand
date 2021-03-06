class Inventory
  attr_accessor :funds, :sugar, :lemons, :cups, :lemon_price, :sugar_price, :lemonade_price
  LEMON = 'lemon'
  SUGAR = 'sugar'

  def initialize
    @lemons = 0
    @funds = 5 # in dollars
    @sugar = 0
    @cups = 0
    @market = Market.new
    @lemon_price = 0
  end

  def make_sale(consumers)
    cups_sold = [consumers, cups].min # returns the maximum number of cups sold (either the lowest amount of paying consumers or the amount of cups for sale)
    @funds += cups_sold * @lemonade_price
    @cups = 0
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

  def get_price(item)
    # case ingredient_price
    # when 'lemon'
    #   @lemon_price
    # when 'sugar'
    #   @sugar_price
    # else "Can't find #{item}"
    # end
    if item.eql?('lemon')
      @lemon_price
    elsif item.eql?('sugar')
      @sugar_price
    else
      "Item #{item} does not exist"
    end
  end

  def purchase(item, quantity)
    case item

    when 'lemon'
      @lemons += quantity
      @funds -= @lemon_price * quantity
      @lemon_costs = @lemon_price * quantity
    when 'sugar'
      @sugar += quantity
      @funds -= @sugar_price * quantity
      @sugar_costs = @sugar_price * quantity
    else puts "Error making purchase of #{quantity} #{item}"
    end
  end

  def purchase_shits(object)
    # Do shits with the object and return
  end

  def purchase_lemons(quantity)
    # TODO: need to remove these depricated methods and their parents
    @lemons += quantity
    @lemon_costs = @lemon_price * quantity
    @funds -= @lemon_costs
  end

  def purchase_sugar(quantity)
    @sugar += quantity
    @sugar_costs = @sugar_price * quantity
    @funds -= @sugar_costs
  end

  def get_opening_funds
    @intial_funds = @funds
  end

  def calculate_profit
    @funds - (@intial_funds  + @sugar_costs + @lemon_costs) #TODO: need to take into account costs. currently just revenue
  end
end
