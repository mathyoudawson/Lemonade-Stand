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
