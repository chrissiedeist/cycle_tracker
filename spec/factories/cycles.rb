FactoryGirl.define do
  factory :cycle do
    transient do
      pattern  do
        [
          [:bleeding_day, 5, []],
          [:less_fertile_day, 3, []],
          [:more_fertile_day, 8, []],
          [:medium_fertile_day, 6, []],
          [:less_fertile_day, 6, []],
        ]
      end
    end
    start_date Date.today - 30.days
  end
end
