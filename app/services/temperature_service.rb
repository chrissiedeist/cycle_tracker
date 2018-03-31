class TemperatureService

  attr_accessor :temperatures, :peak_day

  def initialize(temperatures, peak_day)
    self.temperatures = temperatures
    self.peak_day = peak_day
  end

  def last_day_of_pre_shift_6
    _last_index_of_pre_shift_6 + 1
  end

  def third_high_after_pre_shift_6
    return nil unless htl

    temperatures[_last_index_of_pre_shift_6 + 3]
  end

  def xth_high_after_pre_shift_6(x)
    return nil unless htl

    temperatures[_last_index_of_pre_shift_6 + x]
  end

  def _last_index_of_pre_shift_6
    temperatures.each_with_index do |temp, index|
      next unless index > peak_day - 3

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
    return nil unless ltl

    (ltl + 0.4).round(2)
  end

  def _three_temps_above?(potential_ltl, index)
    [index + 1, index + 2, index + 3].all? do |i|
      temperatures[i] > potential_ltl
    end
  end

  def _max_of_previous_6(index)
    temperatures[index - 6..index - 1].max
  end
end
