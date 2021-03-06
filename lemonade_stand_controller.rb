require_relative 'lemonade_stand.rb'

class LemonadeStandController
  def initialize
    @game = LemonadeStand.new
  end

  def play_game
    while @game.funds?
      @game.set_market_prices
      @game.purchase('lemon')
      @game.purchase('sugar')
      #@game.purchase_lemons
      #@game.purchase_sugar
      @game.make_lemonade
      @game.set_lemonade_price
      @game.generate_population
      @game.sell_lemonade
      @game.update_temperature
      @game.calculate_profit
    end
  end
end

game_instance = LemonadeStandController.new
game_instance.play_game
