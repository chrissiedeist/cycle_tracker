require 'rails_helper'

RSpec.describe Cycle, type: :model do
  let(:cycle) do
    FactoryGirl.create(
      :cycle,
      pattern: pattern
      # bleeding_end: bleeding_end,
      # low_end: low_end,
      # high_end: high_end,
      # medium_end: medium_end,
    )
  end

  describe "factory" do
    let(:pattern) do
      [
        [:bleeding_day, 5],
        [:less_fertile_day, 3],
        [:more_fertile_day, 8],
        [:medium_fertile_day, 6],
        [:less_fertile_day, 6],
      ]
    end

    it "sets days appropriately" do
      expect(cycle.days.count).to eq(28)

      expect(cycle.cycle_day(1)).to be_bleeding
      expect(cycle.cycle_day(5)).to be_bleeding
      expect(cycle.cycle_day(6)).to be_less_fertile
      expect(cycle.cycle_day(8)).to be_less_fertile
      expect(cycle.cycle_day(9)).to be_more_fertile
      expect(cycle.cycle_day(16)).to be_more_fertile
      expect(cycle.cycle_day(17)).to be_medium_fertile
      expect(cycle.cycle_day(22)).to be_medium_fertile
      expect(cycle.cycle_day(23)).to be_less_fertile
      expect(cycle.cycle_day(28)).to be_less_fertile
    end
  end

  describe "peak_day" do
    context "high followed by medium" do
      let(:pattern) do
        [
          [:bleeding_day, 5],
          [:less_fertile_day, 3],
          [:more_fertile_day, 8],
          [:medium_fertile_day, 6],
          [:less_fertile_day, 6],
        ]
      end
      it "is the last day of the high fertility days" do
        expect(cycle.peak_day).to eq(16)
      end
    end

    context "high followed by low" do
      let(:pattern) do
        [
          [:bleeding_day, 5],
          [:less_fertile_day, 3],
          [:more_fertile_day, 8],
          [:less_fertile_day, 12],
        ]
      end

      it "is the last day of the high fertility days" do
        expect(cycle.peak_day).to eq(16)
      end
    end

    context "anomaly high in the middle" do
      let(:pattern) do
        [
          [:bleeding_day, 5],
          [:less_fertile_day, 3],
          [:more_fertile_day, 1],
          [:medium_fertile_day, 3],
          [:more_fertile_day, 4],
          [:less_fertile_day, 12],
        ]
      end

      it "is the last day of the high fertility days" do
        expect(cycle.peak_day).to eq(16)
      end
    end

    context "no high day" do
      let(:pattern) do
        [
          [:bleeding_day, 5],
          [:less_fertile_day, 3],
          [:medium_fertile_day, 3],
        ]
      end

      it "is unknown" do
        expect(cycle.peak_day).to eq("unknown")
      end
    end

    context "no days" do
      let(:pattern) { [ ] }

      it "is unknown" do
        expect(cycle.peak_day).to eq("unknown")
      end
    end
  end

  describe "ltl" do
  end

  describe "htl" do
  end
end
