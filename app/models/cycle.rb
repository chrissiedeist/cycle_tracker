class Cycle < ActiveRecord::Base
  has_many :days

  def cycle_day(number)
    days.where(number: number).take
  end

  def peak_day
    candidates = []
    days.order(:number).each do |day|
      candidates << day.number if _is_local_peak?(day)
    end

    return "unknown" if candidates.empty?

    candidates.last
  end

  def _is_local_peak?(day)
    return false unless day.more_fertile?

    next_day = _next_day(day)
    next_day.medium_fertile? || next_day.less_fertile?
  end

  def _next_day(day)
    cycle_day(day.number + 1)
  end
end
