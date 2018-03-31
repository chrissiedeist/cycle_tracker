require 'rails_helper'

RSpec.describe TemperatureService do
  subject { TemperatureService.new(temperatures) }

  context "more than three days above peak" do
    let(:temperatures) do 
      [ 97.9,
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

    describe "ltl" do
      it "finds the ltl" do
        expect(subject.ltl).to eq(97.6)
        expect(subject.htl).to eq(98)
        expect(subject.last_day_of_pre_shift_6).to eq(20)
      end
    end
  end
end
