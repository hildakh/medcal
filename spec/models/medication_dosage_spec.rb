require 'rails_helper'

RSpec.describe MedicationDosage, type: :model do
  describe "Validations" do
    it "is valid with all attributes" do
      medication_dosage = build(:medication_dosage)
      expect(medication_dosage).to be_valid
    end

    it "is invalid without a unit_price" do
      medication_dosage = build(:medication_dosage, unit_price: nil)
      expect(medication_dosage).not_to be_valid
      expect(medication_dosage.errors[:unit_price]).to include("can't be blank")
    end

    it "is invalid if unit_price is not greater than 0" do
      medication_dosage = build(:medication_dosage, unit_price: -5)
      expect(medication_dosage).not_to be_valid
      expect(medication_dosage.errors[:unit_price]).to include("must be greater than 0")
    end
  end

  describe "Associations" do
    it "belongs to medication and dosage" do
      medication_dosage = create(:medication_dosage)
      expect(medication_dosage.medication).to be_present
      expect(medication_dosage.dosage).to be_present
    end
  end

  describe "Traits" do
    it "creates a cheap medication dosage" do
      cheap_dosage = create(:medication_dosage, :cheap)
      expect(cheap_dosage.unit_price).to eq(2.00)
    end

    it "creates an expensive medication dosage" do
      expensive_dosage = create(:medication_dosage, :expensive)
      expect(expensive_dosage.unit_price).to eq(50.00)
    end

    it "creates a high dose medication dosage" do
      high_dose_dosage = create(:medication_dosage, :high_dose)
      expect(high_dose_dosage.dosage.amount).to eq("1000 mg")
    end

    it "creates a twice-daily medication dosage" do
      twice_daily_dosage = create(:medication_dosage, :twice_daily)
      expect(twice_daily_dosage.dosage.frequency).to eq("twice daily")
    end
  end
end
