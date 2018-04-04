require 'rails_helper'

RSpec.describe PeakDayService do
  subject { PeakDayService.find(days) }
  context "one local peak" do
  let(:days) do
    cycle = FactoryGirl.create(:cycle)
    day_num = 0
    day_types.map do |day_type|
      day_num += 1
      FactoryGirl.create(day_type, number: day_num, cycle: cycle)
    end
  end
    let(:day_types) do
      (1...28).map do |day_num|
        if day_num < 5
          :bleeding_day
        elsif day_num < 8
          :medium_fertile_day
        elsif day_num < 20
          :more_fertile_day
        else
          :less_fertile_day
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(19)
    end
  end

  context "one local peak" do
  let(:days) do
    cycle = FactoryGirl.create(:cycle)
    day_num = 0
    day_types.map do |day_type|
      binding.pry
      day_num += 1
      FactoryGirl.create(day_type, number: day_num, cycle: cycle)
    end
  end
    let(:day_types) do
      (1...28).map do |day_num|
        if day_num < 5
          :bleeding_day
        elsif day_num < 6
          :medium_fertile_day
        elsif day_num < 8
          :more_fertile_day
        elsif day_num == 9
          :medium_fertile_day
        elsif day_num < 11
          :more_fertile_day
        else
          :less_fertile_day
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(10)
    end
  end
end
