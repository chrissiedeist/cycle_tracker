class TemperatureService

  attr_accessor :temperatures, :peak_day

  def initialize(temperatures, peak_day)
    self.temperatures = temperatures.compact
    self.peak_day = peak_day
  end

  def _temp_on_day(num)
    temperatures[num - 1]
  end

  def self.ltl(temperatures, peak_day)
    new(temperatures, peak_day).ltl
  end

  def self.htl(temperatures, peak_day)
    new(temperatures, peak_day).htl
  end

  def ltl
    return "unknown" if peak_day == "unknown"

    first_high_num =_first_of_3_above_6_previous

    _max_of_previous_6_temps(first_high_num)
  end

  def htl
    return "unknown" if ltl == "unknown"

    (ltl + 0.4).round(2)
  end

  def _first_of_3_above_6_previous
    first = _first_above_previous_6

    return first if _two_additional_temps_above_first?(first)
  end

  def _first_above_previous_6
    _nums_around_peak.each do |num|
      if _temp_on_day(num) > _max_of_previous_6_temps(num)
        return num
      end
    end
  end

  def _two_additional_temps_above_first?(first_num)
    second_highest_temp_after_first_high = temperatures.slice(first_num..-1).sort![-2]

    second_highest_temp_after_first_high >= _temp_on_day(first_num)
  end

  def _max_of_previous_6_temps(num)
    (num - 6 .. num - 1).map do |day|
      _temp_on_day(day)
    end.max
  end

  def _nums_around_peak
    ((peak_day - 3)..(peak_day + 3))
  end
end
