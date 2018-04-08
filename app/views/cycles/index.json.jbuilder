@cycles.each do |cycle|
  cycle.days.each do |day|
    json.partial! "days/day", day: day
  end
end
