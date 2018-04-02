FactoryGirl.define do
  factory :day do
    bleeding Day::Bleeding::None
    sensation Day::Sensations::Dry
    characteristics Day::Characteristics::None
    cervix Day::Cervix::Soft
    temp 98.6
    date Date.today
    number 1
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
