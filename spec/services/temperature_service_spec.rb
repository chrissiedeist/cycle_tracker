require 'rails_helper'

RSpec.describe TemperatureService do
  let(:days) do
    temps.map do |day_num, temp|
      double(:day, :number => day_num, :temp => temp)
    end
  end
  subject { TemperatureService.new(peak_day, days) }

  shared_examples "thermal_shift_start_day_number" do |shift_start_day_number|
    it "returns the correct value" do
      expect(subject.thermal_shift_start_day_number).to eq(shift_start_day_number)
    end
  end

  shared_examples "ltl" do |expected_ltl|
    it "returns the correct value" do
      expect(subject.ltl).to eq(expected_ltl)
    end
  end

  context "no peak" do
    let(:peak_day) { nil }
    let(:temps) { [] }

    include_examples "thermal_shift_start_day_number", nil
    include_examples "ltl", nil
  end

  context "only 5 temps before shift" do
    let(:temps) do
      [
        [1, 97],
        [2, 97],
        [3, 97],
        [4, 98],
        [5, 98],
        [6, 99],
        [7, 99],
        [8, 99],
      ]
    end
    let(:peak_day) { 5 }

    include_examples "thermal_shift_start_day_number", nil
    include_examples "ltl", nil

    context "6 temps before shift but one is nil" do
      let(:temps) do
        [
          [1, 97],
          [2, 97],
          [3, nil],
          [4, 98],
          [5, 98],
          [6, 98],
          [7, 99],
          [8, 99],
          [8, 99],
        ]
      end
      let(:peak_day) { 5 }

      include_examples "thermal_shift_start_day_number", nil
      include_examples "ltl", nil
    end
  end

  context "only 2 high temps" do
    let(:temps) do
      [
        [1, 97],
        [2, 97],
        [3, 97],
        [4, 98],
        [5, 98],
        [6, 98],
        [7, 99],
        [8, 99],
      ]
    end
    let(:peak_day) { 5 }

    include_examples "thermal_shift_start_day_number", nil
    include_examples "ltl", nil

    context "three temps above shift but one is nil" do
      let(:temps) do
        [
          [1, 97],
          [2, 97],
          [3, 97],
          [4, 98],
          [5, 98],
          [6, 98],
          [7, 99],
          [8, nil],
          [9, 99],
        ]
      end
      let(:peak_day) { 5 }

      include_examples "thermal_shift_start_day_number", nil
      include_examples "ltl", nil
    end
  end

  context "sufficient temps on either side of peak" do
    let(:temps) do
      [
        [1, 97],
        [2, 97],
        [3, 97],
        [4, 96],
        [5, 94],
        [6, 97],
        [7, 98],
        [8, 98],
        [9, 98],
        [10, 97],
        [11, 97],
        [12, 97],
      ]
    end

    context "a shift occurs 3 days before peak" do
      let(:peak_day) { 10 }

      include_examples "thermal_shift_start_day_number", 7
      include_examples "ltl", 97
      include_examples "ltl", 97
    end

    context "a shift occurs 4 days before peak" do
      let(:peak_day) { 11 }

      include_examples "thermal_shift_start_day_number", nil
      include_examples "ltl", nil
    end

    context "nils around the peak" do
      context "without enough additional data" do
        let(:temps) do
          [
            [1, 97],
            [2, 97],
            [3, 97],
            [4, 96],
            [5, 94],
            [6, 97],
            [7, 98],
            [8, nil],
            [9, 98],
            [10, 97],
          ]
        end
        let(:peak_day) { 10 }

        include_examples "thermal_shift_start_day_number", nil
        include_examples "ltl", nil
      end

      context "with enough additional data" do
        let(:temps) do
          [
            [1, 97],
            [2, 97],
            [3, 97],
            [4, 96],
            [5, 94],
            [6, 97],
            [7, 98],
            [8, nil],
            [9, 98],
            [10, 98],
            [11, 97],
            [12, 97],
          ]
        end
        let(:peak_day) { 10 }

        include_examples "thermal_shift_start_day_number", nil
        include_examples "ltl", nil
      end
    end
  end
end
