class PeakDayService
  def self.find(fertility_scores)
    new(fertility_scores).find
  end

  def initialize(fertility_scores)
    self.fertility_scores = fertility_scores
  end

  attr_accessor :fertility_scores

  def find
    candidates = []
    fertility_scores.each_with_index do |score, index|
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
    fertility_scores[index + 1]
  end
end
