class Cycle < ActiveRecord::Base
  has_many :days, -> { order(number: :asc) }
  belongs_to :user

  def to_csv
    attributes = [
      :bleeding,
      :sensation,
      :characteristics,
      :cervix,
      :temp,
      :created_at,
      :updated_at,
      :date,
      :number,
      :cycle_id,
      :weight,
      :cramps,
      :irritability,
      :sensitivity,
      :tenderness,
      :drinks,
      :hours_sleep,
    ]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      days.each do |day|
        csv << attributes.map { |attr| day.send(attr) }
      end
    end
  end

  def populated_days
    last_populated_day = days.select(&:has_data?).last
    return [] unless  last_populated_day.present?

    days.select {|day| day.number <= last_populated_day.number }
  end

  def cycle_day(num)
    days.where(:number => num).first
  end

  def populate_days
    (0...35).each do |day_num|
      days.create!(
        {
          date: start_date + day_num.days,
          number: day_num + 1,
        }
      )
    end
  end
end
