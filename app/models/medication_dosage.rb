class MedicationDosage < ApplicationRecord
  belongs_to :medication
  belongs_to :dosage

  validates :unit_price, presence: true, numericality: { greater_than: 0 }
end
