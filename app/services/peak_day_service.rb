class PeakDayService
  def initialize(days)
    self.days = days
  end

  attr_accessor :days

  def peak_day_number
    candidates = []
    days.each do |day|
      candidates << day if _is_local_peak?(day)
    end

    return nil if candidates.empty?

    candidates.last.number
  end

  def _is_local_peak?(day)
    return false unless day.max_score == 3

    next_score = _next_score(day)

    return true if next_score.present? && next_score < day.max_score
  end

  def _next_score(day)
    day.cycle.cycle_day(day.number + 1).max_score
  end
end
