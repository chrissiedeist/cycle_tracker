class Cycle < ActiveRecord::Base
  has_many :days

  def phase_3_start
    peak_day = PeakDayService.find(_fertility_scores)

    return nil unless peak_day.present?

    temperature_service   = TemperatureService.new(_temperatures, peak_day)
    third_day_after_shift = temperature_service.last_day_of_pre_shift_6 + 3
    htl                   = temperature_service.htl

    if _third_temp_greater_than_htl(third_day_after_shift, htl) || 
      _cervix_hard_and_closed_three_days?

      third_day_after_shift
    else
      third_day_after_shift + 1
    end
  end

  def _third_temp_greater_than_htl(day_num, htl)
    day = days.where(number: day_num).take
    temp = day.try(:temp)
    temp && temp > htl
  end

  def _fertility_scores
    days.map(&:max_score)
  end

  def _temperatures
    days.map(&:temp)
  end

  def _cervix_hard_and_closed_three_days?
    false
  end

  def cycle_day(num)
    days.where(:number => num).first
  end

  def populate_days
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
