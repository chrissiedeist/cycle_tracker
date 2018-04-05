require 'rails_helper'

RSpec.describe PeakDayService do
  subject { PeakDayService.find(days) }

  context "no peak yet" do
    let(:days) do
      cycle = FactoryGirl.create(:cycle)
      (1...28).map do |day_num|
        if day_num < 5
          FactoryGirl.create(:bleeding_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 8
          FactoryGirl.create(:medium_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 10
          FactoryGirl.create(:more_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        else
          FactoryGirl.create(:empty_day, cycle: cycle, number: day_num, date: Date.today - (30 - day_num))
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(nil)
    end
  end

  context "one local peak" do
    let(:days) do
      cycle = FactoryGirl.create(:cycle)
      (1...28).map do |day_num|
        if day_num < 5
          FactoryGirl.create(:bleeding_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 8
          FactoryGirl.create(:medium_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 10
          FactoryGirl.create(:more_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        else
          FactoryGirl.create(:less_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(9)
    end
  end

  context "two local peaks" do
    let(:days) do
      cycle = FactoryGirl.create(:cycle)
      (1...28).map do |day_num|
        if day_num < 5
          FactoryGirl.create(:bleeding_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 8
          FactoryGirl.create(:medium_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 10
          FactoryGirl.create(:more_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 12
          FactoryGirl.create(:medium_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        elsif day_num < 14
          FactoryGirl.create(:more_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        else
          FactoryGirl.create(:less_fertile_day, number: day_num, cycle: cycle, date: Date.today - (30 - day_num))
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(13)
    end
  end
end
