class Climate
  def generate_initial_temperature
    Random.new.rand(15..35).round(1)
  end

  def generate_new_temperature(temperature)
    Random.new.rand(temperature-5..temperature+5).round(1)
  end
end
