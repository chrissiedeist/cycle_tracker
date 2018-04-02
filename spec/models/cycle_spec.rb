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
        :sensation => day_data[:sensation] || "d",
        :characteristics => day_data[:characteristics] || "n",
        :cervix => day_data[:cervix],
        :temp => day_data[:temp] || 97.2,
        :date => date,
        :number => number,
      )
    end
  end

  shared_examples "phase 3 start date" do |date|
    it "has a start date of #{date}" do
      expect(subject.phase_3_start).to eq(date)
    end
  end

  shared_examples "ltl" do |ltl|
    it "has an ltl of #{ltl}" do
      expect(subject.ltl).to eq(ltl)
    end
  end

  shared_examples "htl" do |htl|
    it "has an htl of #{htl}" do
      expect(subject.htl).to eq(htl)
    end
  end

  shared_examples "peak day" do |peak_day|
    it "has an peak_day of #{peak_day}" do
      expect(subject.peak_day).to eq(peak_day)
    end
  end

  context "chart 2" do
    let(:day_characteristics) do
      [
        { bleeding: 1 },
        { bleeding: 1 },
        { bleeding: 1 },
        { bleeding: 1 },
        { temp: 97.5, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 97.8, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 97.8, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 97.3, sensation: "w", characteristics: "s", cervix: nil },
        { temp: 97.3, sensation: "d", characteristics: "s", cervix: nil },
        { temp: 97.5, sensation: "d", characteristics: "s", cervix: nil },
        { temp: 97.8, sensation: "d", characteristics: "s", cervix: nil },
        { temp: 97.7, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 98, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 98.2, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 98, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 98.3, sensation: "d", characteristics: "n", cervix: nil },
        { temp: 98.1, sensation: "d", characteristics: "n", cervix: nil },
      ]
    end

    include_examples "phase 3 start date", 16
    include_examples "ltl", 97.8
    include_examples "htl", 98.2
    include_examples "peak day", 11
  end
end
