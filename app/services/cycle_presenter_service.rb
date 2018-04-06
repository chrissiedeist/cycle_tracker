class CyclePresenterService

  def self.call(cycle)
    new(cycle).call
  end

  attr_accessor :peak_day, :last_of_pre_shift_6_num, :ltl, :htl, :phase_3_start

  def call
    self.peak_day = PeakDayService.new(days).peak_day

    temperature_service = TemperatureService.new(days, peak_day).compute

    self.last_of_pre_shift_6_num = temperature_service.last_of_pre_shift_6_num
    self.ltl = temperature_service.ltl
    self.htl = temperature_service.htl
    self.phase_3_start = _phase_3_start

    self
  end

  def phase_at(day_number)
    if day_number < 7
      "less-fertile"
    elsif day_number == peak_day
      "peak-day"
    elsif phase_3_start && number >= phase_3_start
      "less-fertile"
    else
      "medium-fertile"
    end
  end

  def initialize(cycle)
    self.cycle = cycle
    self.days = cycle.populated_days
  end

  private
  attr_accessor :peak_day_service, :temperature_service, :cycle, :days

  def _phase_3_start
    return nil unless _three_days_past_peak?

    return nil unless last_of_pre_shift_6_num

    third_day_after_shift = _third_post_peak_day_after_shift

    if _third_temp_greater_than_htl(third_day_after_shift, htl) ||
      _cervix_hard_and_closed_three_days?(third_day_after_shift)

      third_day_after_shift
    else
      third_day_after_shift + 1
    end
  end

  def _three_days_past_peak?
    return nil unless peak_day.present?

    cycle.populated_days.count >= peak_day + 3
  end

  def _third_post_peak_day_after_shift
    if last_of_pre_shift_6_num > peak_day
      last_of_pre_shift_6_num + 3
    else
      peak_day + 3
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
