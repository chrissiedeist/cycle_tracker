class Cycle < ActiveRecord::Base
  has_many :days

  after_create :_add_blank_days

  attr_accessor :pre_shift_6

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
    PeakDayService.call(self)
  end

  def ltl
    TemperatureService.ltl(temperatures, peak_day)
  end

  def htl
    TemperatureService.htl(temperatures, peak_day)
  end

  def temperatures
    temperatures = days.map(&:temp)
  end

  def _cervix_hard_and_closed_three_days?
    false
  end

  def _add_blank_days
    return if days.length > 0

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
