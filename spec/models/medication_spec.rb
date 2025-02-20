require 'rails_helper'

RSpec.describe Medication, type: :model do
  describe "Validations" do
    it "is valid with a name" do
      medication = build(:medication)
      expect(medication).to be_valid
    end

    it "is invalid without a name" do
      medication = build(:medication, name: nil)
      expect(medication).not_to be_valid
      expect(medication.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      create(:medication, name: "Ibuprofen")  # First record
      duplicate_medication = build(:medication, name: "Ibuprofen") # Duplicate

      expect(duplicate_medication).not_to be_valid
      expect(duplicate_medication.errors[:name]).to include("has already been taken")
    end
  end

  describe "Associations" do
    it "has many medication_dosages" do
      medication = create(:medication)
      dosage1 = create(:dosage)
      dosage2 = create(:dosage)

      create(:medication_dosage, medication: medication, dosage: dosage1)
      create(:medication_dosage, medication: medication, dosage: dosage2)

      expect(medication.medication_dosages.count).to eq(2)
      expect(medication.dosages).to include(dosage1, dosage2)
    end
  end
end
