class Day < ActiveRecord::Base
  belongs_to :cycle

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

  def bleeding?
    bleeding.present?
  end

  def more_fertile?
    max_score == 3
  end

  def medium_fertile?
    max_score == 2
  end

  def less_fertile?
    max_score == 1 || bleeding?
  end
  
  def max_score
   [ 
      CHARACTERISTICS_FERTILITY_SCORE[characteristics],
      SENSATIONS_FERTILITY_SCORE[sensation]
   ].max || 1
  end

  def next_day
    Day.where(:cycle => self.cycle, :number => self.number + 1).first
  end
end
