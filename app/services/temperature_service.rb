class TemperatureService

  attr_accessor :days, :peak_day_number

  def initialize(days, peak_day_number)
    self.days = days
    self.peak_day_number = peak_day_number
  end

  def last_day_of_pre_shift_6
    return nil unless _three_days_past_peak?

    last_day = nil
    days.each do |day|
      next unless day.number > peak_day_number - 3

      potential_ltl = _max_of_previous_6_temps(day.number)

      if _three_temps_above?(potential_ltl, day)
        last_day = day.number
      end
    end

    return last_day
  end

  def _three_days_past_peak?
    peak_day_number.present? && days.count >= peak_day_number + 3
  end

  def _max_of_previous_6_temps(number)
    previous_6_days = _day_range(number - 6, number - 1)
    previous_6_temps = previous_6_days.map(&:temp)
    previous_6_temps.max
  end

  def _three_temps_above?(potential_ltl, day)
    return false unless day_at(day.number + 3).present?

    _day_range(day.number + 1, day.number + 3).all? do |day|
      day.temp > potential_ltl
    end
  end

  def day_at(number)
    days[number - 1]
  end

  def _day_range(start_num, end_num)
    days[start_num - 1..end_num - 1]
  end

  def ltl
    return nil unless last_day_of_pre_shift_6

    _max_of_previous_6_temps(last_day_of_pre_shift_6)
  end

  def htl
    return nil unless ltl

    (ltl + 0.4).round(2)
  end
end
