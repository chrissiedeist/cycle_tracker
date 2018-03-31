require 'rails_helper'

RSpec.describe PeakDayService do
  subject { PeakDayService.find(scores) }

  context "one local peak" do
    let(:scores) do
      (1...28).map do |day_num|
        if day_num < 5
          1
        elsif day_num < 8 
          2
        elsif day_num < 20
          3
        else
          1
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(19)
    end
  end

  context "one local peak" do
    let(:scores) do
      (1...28).map do |day_num|
        if day_num < 5
          1
        elsif day_num < 6
          2
        elsif day_num < 8
          3
        elsif day_num == 9
          2
        elsif day_num < 11
          3
        else
          1
        end
      end
    end

    it "finds the peak day" do
      expect(subject).to eq(10)
    end
  end
end
