class Day < ActiveRecord::Base
  belongs_to :cycle
  module Temperatures
    NormalRange = (96..100).step(0.1)
  end

  module Weight
    NormalRange = (130..150).step(1)
  end

  module Drinks
    NormalRange = (0..6).step(0.5)
  end

  module HoursBadSleep
    NormalRange = (0..8).step(0.5)
  end

  module Mood
    NormalRange = (0..6).step(0.5)
  end

  module Cramps
    Yes = 1
    No = 0
  end

  module Characteristics
    Slippery = "s"
    Tacky = "t"
    None = "n"
    NotObserved = "no"
  end

  module Sensations
    Wet = "w"
    Moist = "m"
    Dry = "d"
    NotObserved = "no"
  end

  module Cervix
    Soft = "s"
    Hard = "h"
    NotObserved = "no"
  end

  module Bleeding
    None = 0
    Light = 1
    Heavy = 2
  end

  validates :characteristics, inclusion: { in: [ Characteristics::Slippery, Characteristics::Tacky, Characteristics::None, nil] }
  validates :sensation, inclusion: { in: [ Sensations::Wet, Sensations::Moist, Sensations::Dry, nil] }
  validates :cervix, inclusion: { in: [ Cervix::Soft, Cervix::Hard, nil ] }
  validates :bleeding, inclusion: { in: [Bleeding::None, Bleeding::Light, Bleeding::Heavy, nil] }
  validates :number, uniqueness: { scope: :cycle }
  validates :date, uniqueness: { scope: :cycle }


  CHARACTERISTICS_FERTILITY_SCORE = {
    Day::Characteristics::Slippery => 3,
    Day::Characteristics::Tacky => 2,
    Day::Characteristics::None => 1,
  }

  SENSATIONS_FERTILITY_SCORE = {
    Day::Sensations::Wet => 3,
    Day::Sensations::Moist => 2,
    Day::Sensations::Dry => 1,
  }

  def bleeding?
    bleeding.present? && bleeding > 0
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
   ].max
  end

  def has_data?
    bleeding? || sensation || characteristics || temp
  end

  def next_day
    Day.where(:cycle => self.cycle, :number => self.number + 1).first
  end

  def previous_day
    Day.where(:cycle => self.cycle, :number => self.number - 1).first
  end
end
