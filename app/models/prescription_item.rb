class PrescriptionItem < ApplicationRecord
  belongs_to :prescription
  belongs_to :medication_dosage

  validates :custom_duration, presence: true, numericality: { greater_than: 0 }

  # Calculate total cost for this medication in the prescription
  def total_cost
    base_cost = medication_dosage.unit_price * custom_duration
    discount_applicable? ? base_cost * 0.9 : base_cost
  end

  # Check if 10% discount applies (30+ days)
  def discount_applicable?
    custom_duration >= 30
  end
end
