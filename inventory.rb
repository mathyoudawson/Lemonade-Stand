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
