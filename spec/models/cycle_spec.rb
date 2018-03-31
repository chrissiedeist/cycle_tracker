require 'rails_helper'

RSpec.describe Cycle, type: :model do
  let(:cycle) do
    FactoryGirl.create(
      :cycle,
      pattern: pattern
    )
  end

  describe "factory" do
    context "without temps" do
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

    context "with temps" do
      let(:pattern) do
        [
          [:bleeding_day, 5, [97.4, 97.4, 97.4, 97.4, 97.3]],
          [:less_fertile_day, 3, [97.5, 97.4, 97.4]],
          [:more_fertile_day, 8, [97.8, 97.4, 97.4, 97.4, 97.4, 97.4, 97.4, 97.4]],
          [:medium_fertile_day, 6, [97.6, 97.7, 97.8, 98.4, 97.4, 97.4]],
          [:less_fertile_day, 6, [97.4, 97.4, 97.4, 97.4, 97.4, 97.4]],
        ]
      end

      it "sets temperaturesappropriately" do
        expect(cycle.cycle_day(1).temp).to eq(97.4)
        expect(cycle.cycle_day(5).temp).to eq(97.3)
        expect(cycle.cycle_day(6).temp).to eq(97.5)
        expect(cycle.cycle_day(9).temp).to eq(97.8)
        expect(cycle.cycle_day(17).temp).to eq(97.6)
        expect(cycle.cycle_day(22).temp).to eq(97.4)
      end
    end
  end

  describe "phase_3_start" do
    context "standard cycle" do
      let(:pattern) do
        [
          [:bleeding_day, 5, [97.4, 97.4, 97.4, 97.4, 97.4]],
          [:less_fertile_day, 3, [97.4, 97.4, 97.2]],
          [:more_fertile_day, 8, [97.1, 97.2, 97.4, 97.3, 97.5, 97.5, 97.5, 97.4]],
          [:medium_fertile_day, 6, [97.6, 97.7, 97.8, 98.4, 97.4, 97.4]],
          [:less_fertile_day, 6, [97.4, 97.4, 97.4, 97.4, 97.4, 97.4]],
        ]
      end

      it "is day 19" do
        expect(cycle.phase_3_start).to eq(19)
      end
    end

    context "third day after peak below htl" do
      let(:pattern) do
        [
          [:bleeding_day, 5, [97.4, 97.4, 97.4, 97.4, 97.4]],
          [:less_fertile_day, 3, [97.4, 97.4, 97.2]],
          [:more_fertile_day, 8, [97.1, 97.2, 97.4, 97.3, 97.5, 97.5, 97.5, 97.4]],
          [:medium_fertile_day, 6, [97.6, 97.7, 97.6, 98.4, 97.4, 97.4]],
          [:less_fertile_day, 6, [97.4, 97.4, 97.4, 97.4, 97.4, 97.4]],
        ]
      end

      it "has a phase_3_start of day of 20" do
        expect(cycle.phase_3_start).to eq(20)
      end
    end

    context "incomplete cycle" do
      let(:pattern) do
        [
          [:bleeding_day, 5, [97.4, 97.4, 97.4, 97.4, 97.4]],
          [:less_fertile_day, 3, [97.4, 97.4, 97.2]],
        ]
      end

      it "has a phase_3_start of day of unknown" do
        expect(cycle.phase_3_start).to eq(nil)
      end
    end
  end
end
