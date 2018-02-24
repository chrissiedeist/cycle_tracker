class Cycle < ActiveRecord::Base
  has_many :days

  after_create :_add_blank_days

  def cycle_day(number)
    days.where(number: number).take
  end

  def phase_3_start
    return "unknown" if htl == "unknown"

    third_day_after_peak = cycle_day(peak_day + 3)

    if third_day_after_peak.temp >= htl 
      return third_day_after_peak.number
    elsif _cervix_hard_and_closed_three_days?
      return third_day_after_peak.number
    else
      peak_day + 4
    end
  end

  def peak_day
    candidates = []
    days.order(:number).each do |day|
      candidates << day.number if _is_local_peak?(day)
    end

    return "unknown" if candidates.empty?

    candidates.last
  end

  def htl
    return "unknown" if ltl == "unknown"

    (ltl + 0.4).round(2)
  end

  def ltl
    return "unknown" if peak_day == "unknown"

    first_high_num =_first_of_3_above_6_previous

    _max_of_previous_6_temps(first_high_num)
  end

  def _first_of_3_above_6_previous
    first = _first_above_previous_6

    return first if _two_temps_above_first?(first)
  end

  def _two_temps_above_first?(first_num)
    first_day = cycle_day(first_num)

    days_after_first_high = days.where("number > ? and temp > ?", first_num, first_day.temp)
    days_after_first_high.count >= 2
  end

  def _first_above_previous_6
    _nums_around_peak.each do |num|
      day = cycle_day(num)
      if day.temp > _max_of_previous_6_temps(num)
        return num
      end
    end
  end

  def _nums_around_peak
    ((peak_day - 3)..(peak_day + 3))
  end

  def _max_of_previous_6_temps(num)
    (1..6).map do |i|
      cycle_day(num - i).temp
    end.max
  end

  def _is_local_peak?(day)
    return false unless day.more_fertile?

    next_day = _next_day(day)
    next_day.medium_fertile? || next_day.less_fertile?
  end

  def _next_day(day)
    cycle_day(day.number + 1)
  end

  def _cervix_hard_and_closed_three_days?
    false
  end

  def _add_blank_days
    (0...40).each do |day_num|
      days.create(
        {
          date: start_date + day_num.days,
          number: day_num,
        }
      )
    end
  end
end
