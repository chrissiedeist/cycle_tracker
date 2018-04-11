class CyclePresenterService

  def self.build(cycle)
    new(cycle).build
  end

  attr_accessor :cycle

  def build
    days = cycle.populated_days

    self.peak_day_service = PeakDayService.new(days)
    self.temperature_service = TemperatureService.new(peak_day_number, days)

    self
  end

  def peak_day_number
    peak_day_service.peak_day_number
  end

  def thermal_shift_start_day_number
    temperature_service.thermal_shift_start_day_number
  end

  def ltl
    temperature_service.ltl
  end

  def htl
    temperature_service.htl
  end

  def phase_3_start
    return nil unless thermal_shift_start_day_number.present?

    number_of_third_day_after_shift = _third_post_peak_day_number_after_shift

    return nil unless number_of_third_day_after_shift.present?

    if _third_temp_greater_than_htl(number_of_third_day_after_shift, htl) ||
        _cervix_hard_and_closed_three_days?(number_of_third_day_after_shift)

      number_of_third_day_after_shift
    else
      number_of_third_day_after_shift + 1
    end
  end


  def phase_at(day_number)
    if day_number < 7
      "less-fertile"
    elsif day_number == peak_day_number
      "peak-day"
    elsif phase_3_start && day_number >= phase_3_start
      "less-fertile"
    else
      "medium-fertile"
    end
  end

  def initialize(cycle)
    self.cycle = cycle
  end

  private
  attr_accessor :peak_day_service, :temperature_service

  def _third_post_peak_day_number_after_shift
    if thermal_shift_start_day_number > peak_day_number
      thermal_shift_start_day_number + 2
    else
      peak_day_number + 3
    end
  end

  def _third_temp_greater_than_htl(day_num, htl)
    day = cycle.days.where(number: day_num).take
    temp = day.try(:temp)
    temp && temp > htl
  end

  def _cervix_hard_and_closed_three_days?(third_day_after_shift)
    [0, 1, 2].all? do |days_ago|
      day = cycle.cycle_day(third_day_after_shift - days_ago)
      day.cervix == Day::Cervix::Hard
    end
  end
end
