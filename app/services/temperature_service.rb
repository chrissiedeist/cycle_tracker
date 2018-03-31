class TemperatureService

  attr_accessor :temperatures

  def initialize(temperatures)
    self.temperatures = temperatures
  end

  def last_day_of_pre_shift_6
    _last_index_of_pre_shift_6 + 1
  end

  def _last_index_of_pre_shift_6
    temperatures.each_with_index do |temp, index|
      next unless index > 7

      potential_ltl = _max_of_previous_6(index)

      if _three_temps_above?(potential_ltl, index)
        return index
      end
    end
  end

  def ltl
    _max_of_previous_6(_last_index_of_pre_shift_6)
  end

  def htl
    return nil if ltl.nil?

    (ltl + 0.4).round(2)
  end

  def _three_temps_above?(potential_ltl, index)
    [index, index + 1, index + 2].all? do |i|
      temperatures[i] > potential_ltl
    end
  end

  def _max_of_previous_6(index)
    temperatures[index - 6..index - 1].max
  end
end
