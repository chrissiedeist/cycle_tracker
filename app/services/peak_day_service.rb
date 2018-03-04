class PeakDayService
  def self.call(cycle)
    new(cycle).call
  end

  def initialize(cycle)
    self.cycle = cycle
    self.days = cycle.days
  end

  attr_accessor :cycle, :days

  def call
    candidates = []
    days.order(:number).each do |day|
      candidates << day.number if _is_local_peak?(day)
    end

    return "unknown" if candidates.empty?

    candidates.last
  end

  def _is_local_peak?(day)
    return false unless day.more_fertile?

    next_day = cycle.cycle_day(day.number + 1)
    next_day.medium_fertile? || next_day.less_fertile?
  end


end
