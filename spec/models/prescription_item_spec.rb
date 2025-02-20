require 'rails_helper'

RSpec.describe PrescriptionItem, type: :model do
  describe "Validations" do
    it "is valid with all attributes" do
      prescription_item = build(:prescription_item)
      expect(prescription_item).to be_valid
    end

    it "is invalid without a custom duration" do
      prescription_item = build(:prescription_item, custom_duration: nil)
      expect(prescription_item).not_to be_valid
      expect(prescription_item.errors[:custom_duration]).to include("can't be blank")
    end

    it "is invalid if custom duration is not greater than 0" do
      prescription_item = build(:prescription_item, custom_duration: 0)
      expect(prescription_item).not_to be_valid
      expect(prescription_item.errors[:custom_duration]).to include("must be greater than 0")
    end
  end

  describe "Associations" do
    it "belongs to a prescription" do
      prescription_item = create(:prescription_item)
      expect(prescription_item.prescription).to be_present
    end

    it "belongs to a medication dosage" do
      prescription_item = create(:prescription_item)
      expect(prescription_item.medication_dosage).to be_present
    end
  end

  describe "Cost Calculation" do
    it "calculates total cost correctly without discount" do
      prescription_item = create(:prescription_item, custom_duration: 10)
      expected_cost = prescription_item.medication_dosage.unit_price * 10
      expect(prescription_item.total_cost).to eq(expected_cost)
    end

    it "applies a 10% discount for durations of 30 days or more" do
      prescription_item = create(:prescription_item, :long_duration)
      expected_cost = prescription_item.medication_dosage.unit_price * 30 * 0.9 # Apply discount
      expect(prescription_item.total_cost).to eq(expected_cost)
    end

    it "does not apply a discount for durations under 30 days" do
      prescription_item = create(:prescription_item, custom_duration: 29)
      expected_cost = prescription_item.medication_dosage.unit_price * 29
      expect(prescription_item.total_cost).to eq(expected_cost)
    end
  end

  describe "Discount Logic" do
    it "returns true for durations 30 days or more" do
      prescription_item = build(:prescription_item, custom_duration: 30)
      expect(prescription_item.discount_applicable?).to be true
    end

    it "returns false for durations less than 30 days" do
      prescription_item = build(:prescription_item, custom_duration: 29)
      expect(prescription_item.discount_applicable?).to be false
    end
  end
end
