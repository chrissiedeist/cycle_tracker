class PeakDayService
  def self.find(fertilty_scores)
    new(fertilty_scores).find
  end

  def initialize(fertilty_scores)
    self.fertilty_scores = fertilty_scores
  end

  attr_accessor :fertilty_scores

  def find
    candidates = []
    fertilty_scores.each_with_index do |score, index|
      candidates << index if _is_local_peak?(score, index)
    end

    return nil if candidates.empty?

    peak_index = candidates.last
    peak_index + 1
  end

  def _is_local_peak?(score, index)
    return false unless score == 3

    next_score = _next_score(index)

    return true if next_score.present? && next_score < score
  end

  def _next_score(index)
    fertilty_scores[index + 1]
  end
end
