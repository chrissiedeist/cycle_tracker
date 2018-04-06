require 'rails_helper'

RSpec.describe TemperatureService do
  subject { TemperatureService.new(days, peak_day).compute }
  let(:days) do
    temps.map do |day_num, temp|
      double(:day, :number => day_num, :temp => temp)
    end
  end

  context "no peak" do
    let(:peak_day) { nil }
    let(:temps) do
      [ [1, 98],
        [2, 97.9],
        [3, 98],
        [4, 98],
        [5, 97.5],
        [6, 97.8],
        [7, 97.1],
      ]
    end

    it "returns nil for ltl" do
      expect(subject.ltl).to eq(nil)
    end

    it "returns nil for htl" do
      expect(subject.htl).to eq(nil)
    end

    it "returns nil for last_of_pre_shift_6_num" do
      expect(subject.last_of_pre_shift_6_num).to eq(nil)
    end
  end

  context "three or more days past peak" do
    context "shift is present" do
      let(:peak_day) { 18 }
      let(:temps) do
        [ [1, 98],
          [2, 97.9],
          [3, 98],
          [4, 98],
          [5, 97.5],
          [6, 97.8],
          [7, 97.1],
          [8, 97.3],
          [9, 97.6],
          [10, 97.5],
          [11, 97.5],
          [12, 97.3],
          [13, 97.3],
          [14, 97.5],
          [15, 97.5],
          [16, 97.6],
          [17, 97.3],
          [18, 97.3],
          [19, 97.3],
          [20, 97.6],
          [21, 97.8],
          [22, 97.8],
          [23, 97.7],
          [24, 97.9],
          [25, 98.1],
        ]
      end

      it "finds the ltl" do
        expect(subject.ltl).to eq(97.6)
      end

      it "finds the htl" do
        expect(subject.htl).to eq(98.0)
      end

      it "calculates last_of_pre_shift_6_num" do
        expect(subject.last_of_pre_shift_6_num).to eq(20)
      end
    end

    context "shift is not present" do
      let(:peak_day) { 19 }
      let(:temps) do
        [ [1, 98],
          [2, 97],
          [3, 98],
          [4, 98],
          [5, 97],
          [6, 97],
          [7, 97],
          [8, 97],
          [9, 97],
          [10, 97],
          [11, 97],
          [12, 97],
          [13, 97],
          [14, 97],
          [15, 97],
          [16, 97],
          [17, 97],
          [18, 97],
          [19, 97],
          [20, 97],
          [21, 97.8],
          [22, 97.8],
        ]
      end

      it "returns nil for ltl" do
        expect(subject.ltl).to eq(nil)
      end

      it "returns nil for htl" do
        expect(subject.htl).to eq(nil)
      end

      it "returns nil for last_of_pre_shift_6_num" do
        expect(subject.last_of_pre_shift_6_num).to eq(nil)
      end
    end

    context "peak is during preshift" do
      let(:peak_day) { 11 }
      let(:temps) do
        [ [1, nil],
          [2, nil],
          [3, nil],
          [4, nil],
          [5, nil],
          [6, 97.8],
          [7, 97.8],
          [8, 97.3],
          [9, 97.6],
          [10, 97.5],
          [11, 97.8],
          [12, 97.7],
          [13, 98],
          [14, 98.2],
          [15, 98],
          [16, 98.3],
        ]
      end

      it "finds the ltl" do
        expect(subject.ltl).to eq(97.8)
      end

      it "calculates last_of_pre_shift_6_num" do
        expect(subject.last_of_pre_shift_6_num).to eq(12)
      end

      it "calculates last_of_pre_shift_6_num" do
        expect(subject.shift_start_day_num).to eq(13)
      end
    end

    context "nils around peak" do
      let(:peak_day) { 7 }
      let(:temps) do
        [ [1, nil],
          [2, nil],
          [3, nil],
          [4, nil],
          [5, nil],
          [6, nil],
          [7, 97.8],
          [8, 97.3],
          [9, 97.6],
          [10, 97.5],
          [11, 97.8],
          [12, 97.7],
          [13, 98],
          [14, 98.2],
          [15, 98],
          [16, 98.3],
        ]
      end

      it "finds the ltl" do
        expect(subject.ltl).to eq(nil)
      end

      it "calculates last_of_pre_shift_6_num" do
        expect(subject.last_of_pre_shift_6_num).to eq(nil)
      end
    end
  end
end
