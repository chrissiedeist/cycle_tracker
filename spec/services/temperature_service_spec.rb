require 'rails_helper'

RSpec.describe TemperatureService do
  subject { TemperatureService.new(days, peak_day) }
  let(:days) do
    number = 0
    temps.map do |temp|
      number += 1
      double(:day, :number => number, :temp => temp)
    end
  end

  context "more than three days above peak" do
    let(:peak_day) { 18 }
    let(:temps) do
      [ 98,
        97.9,
        98,
        98,
        97.5,
        97.8,
        97.1,
        97.3,
        97.6,
        97.5,
        97.5,
        97.3,
        97.3,
        97.5,
        97.5,
        97.6,
        97.3,
        97.3,
        97.3,
        97.6,
        97.8,
        97.8,
        97.7,
        97.9,
        98.1,
      ]
    end

    it "finds the ltl" do
      expect(subject.ltl).to eq(97.6)
    end

    it "finds the htl" do
      expect(subject.htl).to eq(98.0)
    end

    it "calculates last_day_of_pre_shift_6" do
      expect(subject.last_day_of_pre_shift_6).to eq(21)
    end
  end

  context "no peak" do
    let(:peak_day) { nil }
    let(:temps) do
      [ 98,
        97.9,
        98,
        98,
        97.5,
        97.8,
        97.1,
      ]
    end

    it "returns nil for ltl" do
      expect(subject.ltl).to eq(nil)
    end

    it "returns nil for htl" do
      expect(subject.htl).to eq(nil)
    end

    it "returns nil for last_day_of_pre_shift_6" do
      expect(subject.last_day_of_pre_shift_6).to eq(nil)
    end
  end

  context "exactly 3 days past peak" do
    let(:peak_day) { 19 }
    let(:temps) do
      [ 98.8,
        98.3,
        96.9,
        97.3,
        97.3,
        97.3,
        97.5,
        97.5,
        97.3,
        97.2,
        97.1,
        97.1,
        97.3,
        97.6,
        97.6,
        97.6,
        97.5,
        97.7,
        97.7,
        98.1,
        98.3,
        98.3,
      ]
    end

    it "returns ltl" do
      expect(subject.ltl).to eq(97.7)
    end

    it "returns nil for htl" do
      expect(subject.htl).to eq(98.1)
    end

    it "returns nil for last_day_of_pre_shift_6" do
      expect(subject.last_day_of_pre_shift_6).to eq(19)
    end
  end

  context "2 days past peak" do
    let(:peak_day) { 19 }
    let(:temps) do
      [ 98,
        97.9,
        98,
        98,
        97.5,
        97.8,
        97.1,
        97.3,
        97.6,
        97.5,
        97.5,
        97.3,
        97.3,
        97.5,
        97.5,
        97.6,
        97.3,
        97.3,
        97.3,
        97.6,
        97.8,
      ]
    end

    it "returns nil for ltl" do
      expect(subject.ltl).to eq(nil)
    end

    it "returns nil for htl" do
      expect(subject.htl).to eq(nil)
    end

    it "returns nil for last_day_of_pre_shift_6" do
      expect(subject.last_day_of_pre_shift_6).to eq(nil)
    end
  end
end
