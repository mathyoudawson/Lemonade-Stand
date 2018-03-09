class Market
  def calculate_lemon_price
    Random.new.rand(0.25..0.50).round(2) # returns random number between 0.25-0.5 rounded to the nearest 2dp
  end

  def calculate_sugar_price
    Random.new.rand(0.02..0.05).round(2) # returns random number between 0.02-0.05 rounded to the nearest 2dp
  end
end
