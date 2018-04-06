class TemperatureService
  attr_accessor :peak_day_number, :days

  def initialize(peak_day_number, days)
    self.peak_day_number = peak_day_number
    self.days = days
  end

  def ltl
    @ltl ||= _ltl
  end


  def htl
    return nil unless ltl.present?

    (ltl + 0.4).round(2)
  end

  def thermal_shift_start_day_number
    thermal_shift_start_day.presence && thermal_shift_start_day.number
  end

  private

  def thermal_shift_start_day
    return nil unless peak_day_number.present?

    @thermal_shift_start_day ||= _thermal_shift_start_day
  end

  def _ltl
    return nil unless thermal_shift_start_day.present?

    _max_of_previous_6_temps(_thermal_shift_start_day)
  end

  def _thermal_shift_start_day
    _potential_shift_start_days.each do |potential_shift_start|

      return potential_shift_start if _is_shift_start?(potential_shift_start)
    end

    return nil
  end

  def _potential_shift_start_days
    _day_range(peak_day_number - 3, peak_day_number + 3)
  end

  def _is_shift_start?(day)
    max_of_previous_six_temps = _max_of_previous_6_temps(day)
    min_of_three_high_temps = _min_of_three_high_temps(day)

    return nil unless max_of_previous_six_temps.present?
    return nil unless min_of_three_high_temps.present?

    return day if max_of_previous_six_temps < min_of_three_high_temps
  end

  def _max_of_previous_6_temps(day)
    previous_6_temps = _day_range(day.number - 6, day.number - 1).map(&:temp).compact

    return nil unless previous_6_temps.count == 6

    previous_6_temps.max
  end

  def _min_of_three_high_temps(day)
    three_temps = _day_range(day.number, day.number + 2).map(&:temp).compact

    return nil unless three_temps.count == 3

    three_temps.min
  end
  #
  # def _last_of_pre_shift_6_num
  #   return nil if shift_start_day_num.nil?
  #
  #   shift_start_day_num - 1
  # end
  #
  def _day_range(start_num, end_num)
    days.select do |day|
      day.number >= start_num &&
        day.number <= end_num
    end
  end
end
