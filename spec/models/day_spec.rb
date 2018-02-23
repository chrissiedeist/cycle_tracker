require 'rails_helper'

RSpec.describe Day, type: :model do
  describe "score" do
    let(:day) { FactoryGirl.create(:day, sensation: sensation, characteristics: characteristics) }
    shared_examples "it is a more fertile day" do
      it "is a more fertile day" do
        expect(day).to be_more_fertile
      end
    end

    shared_examples "it is a medium fertile day" do
      it "is a medium fertile day" do
        expect(day).to be_medium_fertile
      end
    end

    shared_examples "it is a less fertile day" do
      it "is a less fertile day" do
        expect(day).to be_less_fertile
      end
    end

    context "sensation is w" do
      let(:sensation) { "w" }

      context "characteristics are stretchy" do
        let(:characteristics) { "s" }
        include_examples "it is a more fertile day"
      end

      context "characteristics are tacky" do
        let(:characteristics) { "t" }
        include_examples "it is a more fertile day"
      end

      context "characteristics are none" do
        let(:characteristics) { "n" }
        include_examples "it is a more fertile day"
      end
    end

    context "sensation is moist" do
      let(:sensation) { "m" }

      context "characteristics are stretchy" do
        let(:characteristics) { "s" }
        include_examples "it is a more fertile day"
      end

      context "characteristics are tacky" do
        let(:characteristics) { "t" }
        include_examples "it is a medium fertile day"
      end

      context "characteristics are none" do
        let(:characteristics) { "n" }
        include_examples "it is a medium fertile day"
      end
    end

    context "sensation is dry" do
      let(:sensation) { "d" }

      context "characteristics are stretchy" do
        let(:characteristics) { "s" }
        include_examples "it is a more fertile day"
      end

      context "characteristics are tacky" do
        let(:characteristics) { "t" }
        include_examples "it is a medium fertile day"
      end

      context "characteristics are none" do
        let(:characteristics) { "n" }
        include_examples "it is a less fertile day"
      end
    end
  end
end
