require 'rails_helper'

RSpec.describe Prescription, type: :model do
  describe "Validations" do
    it "is valid with a patient name and budget" do
      prescription = build(:prescription)
      expect(prescription).to be_valid
    end

    it "is invalid without a patient name" do
      prescription = build(:prescription, patient_name: nil)
      expect(prescription).not_to be_valid
      expect(prescription.errors[:patient_name]).to include("can't be blank")
    end

    it "is invalid with a budget of 0 or less" do
      prescription = build(:prescription, budget: 0)
      expect(prescription).not_to be_valid
      expect(prescription.errors[:budget]).to include("must be greater than 0")
    end
  end

  describe "Associations" do
    it "has many prescription items" do
      prescription = create(:prescription, items_count: 3)
      expect(prescription.prescription_items.count).to eq(3)
    end

    it "has many medication dosages through prescription items" do
      prescription = create(:prescription)
      expect(prescription.medication_dosages).to all(be_a(MedicationDosage))
    end

    it "has many medications through medication dosages" do
      prescription = create(:prescription)
      expect(prescription.medications).to all(be_a(Medication))
    end
  end

  describe "Budget Validation" do
    it "is valid within budget using cheap medication and short duration" do
      prescription = create(:prescription, budget: 50, custom_items: [ { medication_dosage: create(:medication_dosage, :cheap), custom_duration: 7 } ])

      expect(prescription.valid_within_budget?).to be true
    end

    it "is invalid if over budget" do
      prescription = create(:prescription, :over_budget)
      expect(prescription.valid_within_budget?).to be false
    end
  end

  describe "Total Cost Calculation" do
    it "calculates the correct total cost" do
      prescription = create(:prescription, items_count: 2)
      expected_cost = prescription.prescription_items.sum(&:total_cost)
      expect(prescription.total_cost).to eq(expected_cost)
    end
  end

  describe "Suggested Reductions" do
    it "returns empty within budget using cheap medication and short duration" do
      prescription = create(:prescription, budget: 50, custom_items: [ { medication_dosage: create(:medication_dosage, :cheap), custom_duration: 7 } ])
      expect(prescription.suggested_reductions).to be_empty
    end

    it "suggests reductions if over budget" do
      prescription = create(:prescription, :over_budget)
      suggestions = prescription.suggested_reductions
      expect(suggestions).not_to be_empty
      expect(suggestions.first[:suggested_duration]).to be < suggestions.first[:original_duration]
    end
  end

  describe "Applying Adjustments" do
    it "does not change prescription if already within budget" do
      # Ensure this prescription starts truly within budget
      prescription = create(:prescription, budget: 50, custom_items: [
        { medication_dosage: create(:medication_dosage, :cheap), custom_duration: 7 },
        { medication_dosage: create(:medication_dosage, :cheap), custom_duration: 7 }
      ])

      expect(prescription.valid_within_budget?).to be true  # ✅ Check that it's already under budget

      original_durations = prescription.prescription_items.pluck(:custom_duration)

      prescription.apply_adjustments

      new_durations = prescription.prescription_items.pluck(:custom_duration)
      expect(new_durations).to eq(original_durations)  # ✅ Ensure no changes occur
    end

    it "adjusts durations to fit within budget" do
      prescription = create(:prescription, :over_budget)

      prescription.apply_adjustments

      expect(prescription.valid_within_budget?).to be true
    end
  end
end
