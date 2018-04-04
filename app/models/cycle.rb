class Cycle < ActiveRecord::Base
  has_many :days, -> { order(number: :asc) }
  belongs_to :user

  def phase_3_start
    return nil unless _three_days_past_peak?

    return nil unless last_day_of_pre_shift_6

    third_day_after_shift = last_day_of_pre_shift_6 + 3

    if _third_temp_greater_than_htl(third_day_after_shift, htl) ||
      _cervix_hard_and_closed_three_days?(third_day_after_shift)

      third_day_after_shift
    else
      third_day_after_shift + 1
    end
  end

  def peak_day
    PeakDayService.find(_populated_days)
  end

  def xth_day_of_pre_shift_6(x)
  end

  def last_day_of_pre_shift_6
    temperature_service.last_day_of_pre_shift_6
  end

  def htl
    temperature_service.htl
  end

  def ltl
    temperature_service.ltl
  end

  def temperature_service
    TemperatureService.new(_populated_days, peak_day)
  end

  def _three_days_past_peak?
    return nil unless peak_day.present?

    _populated_days.count >= peak_day + 3
  end

  def _populated_days
    days.select(&:has_data?)
  end

  def _third_temp_greater_than_htl(day_num, htl)
    day = days.where(number: day_num).take
    temp = day.try(:temp)
    temp && temp > htl
  end

  def _cervix_hard_and_closed_three_days?(third_day_after_shift)
    [0, 1, 2].all? do |days_ago|
      day = cycle_day(third_day_after_shift - days_ago)
      day.cervix == Day::Cervix::Hard
    end
  end

  def cycle_day(num)
    days.where(:number => num).first
  end

  def populate_days
    (0...35).each do |day_num|
      days.create!(
        {
          date: start_date + day_num.days,
          number: day_num + 1,
        }
      )
    end
  end
end
