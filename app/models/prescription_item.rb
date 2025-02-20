class PrescriptionItem < ApplicationRecord
  belongs_to :prescription
  belongs_to :medication_dosage

  validates :custom_duration, presence: true, numericality: { greater_than: 0 }

  # Calculate total cost with correct discount logic
  def total_cost(duration = custom_duration)
    base_cost = medication_dosage.unit_price * duration
    discount_applicable?(duration) ? base_cost * 0.9 : base_cost
  end

  # Check if 10% discount applies (30+ days)
  def discount_applicable?(duration = custom_duration)
    duration >= 30
  end
end
