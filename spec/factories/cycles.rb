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

    days do
      number = 1
      date = start_date + number.days

      pattern.map do |type, num_days, temps=nil|
        (1..num_days).map do |i|
          temp = temps ? temps[i - 1] : 98.6
          day = FactoryGirl.create(type, number: number, date: date, temp: temp)
          number +=1
          date += 1.day
          day
        end
      end.flatten
    end

    start_date Date.today - 30.days
  end
end
