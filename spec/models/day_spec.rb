require 'rails_helper'

RSpec.describe Day, type: :model do

  describe "valid" do
    let(:sensation) { Day::Sensations::Wet }
    let(:characteristics) { Day::Characteristics::Slippery }
    let(:temp) { 98.2 }
    let(:day) { FactoryGirl.build(:day, sensation: sensation, characteristics: characteristics, temp: temp) }

    shared_examples "invalid" do
      it "is invalid" do
        expect(day).to_not be_valid
      end
    end

    context "invalid characteristics" do
      context "invalid sensation" do
        let(:sensation) { "t" }

        include_examples "invalid"
      end

      context "invalid characteristics" do
        let(:characteristics) { "x" }

        include_examples "invalid"
      end
    end
  end

  describe "fertility_score" do
    let(:day) { FactoryGirl.create(:day, date: Date.parse("28-01-2018"), sensation: sensation, characteristics: characteristics) }

    shared_examples "it is a more fertile day" do
      it "is a more fertile day" do
        expect(day).to be_more_fertile
      end

      it "is not less or medium fertile" do
        expect(day).to_not be_medium_fertile
        expect(day).to_not be_less_fertile
      end

      it "has a max score of 3" do
        expect(day.max_score).to eq(3)
      end
    end

    shared_examples "it is a medium fertile day" do
      it "is a medium fertile day" do
        expect(day).to be_medium_fertile
      end

      it "is not less or more fertile" do
        expect(day).to_not be_less_fertile
        expect(day).to_not be_more_fertile
      end

      it "has a max score of 2" do
        expect(day.max_score).to eq(2)
      end
    end

    shared_examples "it is a less fertile day" do
      it "is a less fertile day" do
        expect(day).to be_less_fertile
      end

      it "is not more or medium fertile" do
        expect(day).to_not be_medium_fertile
        expect(day).to_not be_more_fertile
      end

      it "has a max score of 1" do
        expect(day.max_score).to eq(1)
      end
    end

    context "sensation is w" do
      let(:sensation) { Day::Sensations::Wet }

      context "characteristics are stretchy" do
        let(:characteristics) { Day::Characteristics::Slippery }
        include_examples "it is a more fertile day"
      end

      context "characteristics are tacky" do
        let(:characteristics) { Day::Characteristics::Tacky }
        include_examples "it is a more fertile day"
      end

      context "characteristics are none" do
        let(:characteristics) { Day::Characteristics::None }
        include_examples "it is a more fertile day"
      end
    end

    context "sensation is moist" do
      let(:sensation) { Day::Sensations::Moist }

      context "characteristics are stretchy" do
        let(:characteristics) { Day::Characteristics::Slippery }
        include_examples "it is a more fertile day"
      end

      context "characteristics are tacky" do
        let(:characteristics) { Day::Characteristics::Tacky }
        include_examples "it is a medium fertile day"
      end

      context "characteristics are none" do
        let(:characteristics) { Day::Characteristics::None }
        include_examples "it is a medium fertile day"
      end
    end

    context "sensation is dry" do
      let(:sensation) { Day::Sensations::Dry }

      context "characteristics are stretchy" do
        let(:characteristics) { Day::Characteristics::Slippery }
        include_examples "it is a more fertile day"
      end

      context "characteristics are tacky" do
        let(:characteristics) { Day::Characteristics::Tacky }
        include_examples "it is a medium fertile day"
      end

      context "characteristics are none" do
        let(:characteristics) { Day::Characteristics::None }
        include_examples "it is a less fertile day"
      end
    end

    describe "factories" do
      context "more_fertile_day" do
        let(:day) { FactoryGirl.create(:more_fertile_day) }
        include_examples "it is a more fertile day"
      end

      context "less_fertile_day" do
        let(:day) { FactoryGirl.create(:less_fertile_day) }
        include_examples "it is a less fertile day"
      end

      context "medium_fertile_day" do
        let(:day) { FactoryGirl.create(:medium_fertile_day) }
        include_examples "it is a medium fertile day"
      end

      context "bleeding_day" do
        let(:day) { FactoryGirl.create(:bleeding_day) }
        it "is bleeding" do
          expect(day).to be_bleeding
        end
      end
    end
  end
end
