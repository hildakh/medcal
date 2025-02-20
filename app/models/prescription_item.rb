class PrescriptionItem < ApplicationRecord
  belongs_to :prescription
  belongs_to :medication_dosage

  validates :custom_duration, presence: true, numericality: { greater_than: 0 }

  # Calculate total cost with correct discount logic
  def total_cost(duration = nil)
    duration ||= custom_duration || medication_dosage.dosage.default_duration  # Default to dosage's default_duration if custom_duration is nil
    base_cost = medication_dosage.unit_price * duration
    discount = discount_applicable?(duration) ? 0.9 : 1.0
    total = base_cost * discount

    total
  end

  # Check if 10% discount applies (30+ days)
  def discount_applicable?(duration = nil)
    duration ||= custom_duration || medication_dosage.dosage.default_duration  # Ensure we always get a duration

    duration.to_i >= 30
  end
end
