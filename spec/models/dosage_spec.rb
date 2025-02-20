require 'rails_helper'

RSpec.describe Dosage, type: :model do
  describe "Validations" do
    it "is valid with all attributes" do
      dosage = build(:dosage)
      expect(dosage).to be_valid
    end

    it "is invalid without an amount" do
      dosage = build(:dosage, amount: nil)
      expect(dosage).not_to be_valid
      expect(dosage.errors[:amount]).to include("can't be blank")
    end

    it "is invalid without a frequency" do
      dosage = build(:dosage, frequency: nil)
      expect(dosage).not_to be_valid
      expect(dosage.errors[:frequency]).to include("can't be blank")
    end

    it "is invalid without a default duration" do
      dosage = build(:dosage, default_duration: nil)
      expect(dosage).not_to be_valid
      expect(dosage.errors[:default_duration]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "has many medication_dosages" do
      dosage = create(:dosage)
      medication1 = create(:medication)
      medication2 = create(:medication)

      create(:medication_dosage, dosage: dosage, medication: medication1)
      create(:medication_dosage, dosage: dosage, medication: medication2)

      expect(dosage.medication_dosages.count).to eq(2)
      expect(dosage.medications).to include(medication1, medication2)
    end
  end
end
