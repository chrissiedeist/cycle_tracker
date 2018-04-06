require 'rails_helper'

RSpec.describe Cycle, type: :model do
  subject do
    FactoryGirl.create(
      :cycle,
      :days => days,
    )
  end
  let(:days) do
    number = 0
    date = Date.today - 41.days
    day_characteristics.map do |day_data|
      date += 1
      number += 1
      FactoryGirl.create(
        :day,
        :bleeding => day_data[:bleeding],
        :cervix => day_data[:cervix],
        :temp => day_data[:temp],
        :date => date,
        :number => day_data[:number] || number,
        :score => day_data[:score],
      )
    end
  end

  describe "populated_days" do
    context "no days" do
      let(:day_characteristics) { [ ] }

      it "returns the total number of days" do
        expect(subject.populated_days).to eq([])
      end
    end

    context "no days missing data" do
      let(:day_characteristics) do
        [
          { temp: 97.5, score: 1 },
          { temp: 97.3, score: 3 },
          { temp: 97.3, score: 3 },
        ]
      end

      it "returns the total number of days" do
        expect(subject.populated_days).to eq(days)
      end
    end

    context "days at the end missing data" do
      let(:day_characteristics) do
        [
          { temp: 97.5, score: 1 },
          { temp: 97.3, score: 3 },
          { },
        ]
      end

      it "returns the total number of populated days" do
        expect(subject.populated_days.count).to eq(2)
      end
    end

    context "days in the middle  missing data" do
      let(:day_characteristics) do
        [
          { temp: 97.5, score: 1 },
          { },
          { temp: 97.3, score: 3 },
        ]
      end

      it "returns the total number of populated days" do
        expect(subject.populated_days.count).to eq(3)
      end
    end
  end
end
