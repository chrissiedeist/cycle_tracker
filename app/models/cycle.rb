class Cycle < ActiveRecord::Base
  has_many :days

  attr_accessor :pre_shift_6, :htl, :ltl

  def phase_3_start
    return nil unless peak_day.present?

    self.temperature_service = TemperatureService.new(temperatures, peak_day.num)

    if _xth_high_day_after_thermal_shift(3).temp >= temperature_service.htl || 
      _cervix_hard_and_closed_three_days?

      return _xth_high_day_after_thermal_shift(3).number
    else
      _xth_high_day_after_thermal_shift(4).number
    end
  end

  def _xth_high_day_after_thermal_shift(x)
    day_num = temperature_service.xth_high_after_pre_shift_6(x)

    _cycle_day(day_num)
  end

  def peak_day
    PeakDayService.call(self.days.map(&:max_score)
  end

  def temperatures
    days.map(&:temp)
  end

  def _cycle_day(number)
    days.where(number: number).take
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
