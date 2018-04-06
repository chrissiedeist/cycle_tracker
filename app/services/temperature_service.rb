class TemperatureService
  def initialize(days, peak_day_number)
    self.days = days
    self.peak_day_number = peak_day_number
  end

  attr_accessor :shift_start_day_num, :last_of_pre_shift_6_num, :ltl, :htl

  def compute
    self.shift_start_day_num = _shift_start_day_num
    self.last_of_pre_shift_6_num = _last_of_pre_shift_6_num
    self.ltl = _ltl
    self.htl = _htl

    self
  end

  private
  attr_accessor :days, :peak_day_number

  def _shift_start_day_num
    return unless peak_day_number.present?

    ((peak_day_number - 3)..(peak_day_number + 3)).each do |potential_shift_start|
      return nil if days.count < potential_shift_start + 3

      six_prev_temps = _day_range(potential_shift_start - 6, potential_shift_start - 1).map(&:temp).compact
      three_next_temps = _day_range(potential_shift_start, potential_shift_start + 3).map(&:temp).compact

      return nil if six_prev_temps.empty? || three_next_temps.empty?

      return potential_shift_start if three_next_temps.min > six_prev_temps.max
    end
  end

  def _last_of_pre_shift_6_num
    return nil if shift_start_day_num.nil?

    shift_start_day_num - 1
  end

  def _ltl
    return nil if last_of_pre_shift_6_num.nil?

    pre_shift_6 = _day_range(last_of_pre_shift_6_num - 6, last_of_pre_shift_6_num)

    pre_shift_6.map(&:temp).max
  end

  def _htl
    return nil unless ltl

    (ltl + 0.4).round(2)
  end

  def _day_range(start_num, end_num)
    days[start_num - 1..end_num - 1]
  end
end
