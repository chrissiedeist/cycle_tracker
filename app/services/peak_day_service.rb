class PeakDayService
  def self.call(days)
    new(days).call
  end

  def initialize(days)
    self.days = days
  end

  attr_accessor :cycle, :days

  def call
    candidates = []
    days.sort_by(&:number).each do |day|
      candidates << day.number if _is_local_peak?(day)
    end


    return "unknown" if candidates.empty?

    candidates.last
  end

  def _is_local_peak?(day)
    return false unless day.more_fertile?

    next_day = day.next_day

    return false unless next_day.present?

    next_day.medium_fertile? || next_day.less_fertile?
  end
end
