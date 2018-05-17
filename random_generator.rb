module RandomGenerator
  class Generate
    def random_value(min, max, round)
      Random.new.rand(min..max).round(round)
    end
  end
end
