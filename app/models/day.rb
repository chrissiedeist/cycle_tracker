class Day < ActiveRecord::Base
  CHARACTERISTICS_FERTILITY_SCORE = {
    "s" => 3,
    "t" => 2,
    "n" => 1,
  }
  SENSATIONS_FERTILITY_SCORE = {
    "w" => 3,
    "m" => 2,
    "d" => 1,
  }

  def more_fertile?
    max_score == 3
  end

  def medium_fertile?
    max_score == 2
  end

  def less_fertile?
    max_score == 1
  end
  
  def max_score
   [ 
      CHARACTERISTICS_FERTILITY_SCORE[characteristics],
      SENSATIONS_FERTILITY_SCORE[sensation]
   ].max
  end
end
