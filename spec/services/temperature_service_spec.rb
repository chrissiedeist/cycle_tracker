require 'rails_helper'

RSpec.describe TemperatureService do
  subject { TemperatureService.new(temperatures, peak_day) }

  context "more than three days above peak" do
    let(:peak_day) { 18 }
    let(:temperatures) do 
      [ 0, 
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
      expect(subject.htl).to eq(98)
    end

    it "finds the last_day_of_pre_shift_6" do
      expect(subject.last_day_of_pre_shift_6).to eq(20)
    end
  end
end
