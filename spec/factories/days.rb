FactoryGirl.define do
  factory :day do
    transient do
      score 1
    end

    sensation do
      case score
      when 1
        Day::Sensations::Dry
      when 2
        Day::Sensations::Moist
      when 3
        Day::Sensations::Wet
      end
    end
    characteristics do
      case score
      when 1
        Day::Characteristics::None
      when 2
        Day::Characteristics::Tacky
      when 3
        Day::Characteristics::Slippery
      end
    end
    cervix Day::Cervix::Soft
    temp 98.6
    date Date.today
    number 1
  end

  factory :empty_day, parent: :day do
    bleeding nil
    sensation nil
    characteristics nil
    cervix nil
    temp nil
    date nil
    number nil
  end

  factory :bleeding_day, parent: :day do
    bleeding 1
    sensation nil
    characteristics nil
  end

  factory :more_fertile_day, parent: :day do
    sensation "w"
    characteristics "s"
  end

  factory :medium_fertile_day, parent: :day do
    sensation "m"
    characteristics "t"
  end

  factory :less_fertile_day, parent: :day do
    sensation "d"
    characteristics "n"
  end
end
