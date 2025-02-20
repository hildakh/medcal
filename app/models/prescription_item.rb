class PrescriptionItem < ApplicationRecord
  belongs_to :prescription
  belongs_to :medication_dosage

  validates :custom_duration, presence: true, numericality: { greater_than: 0 }

  # Calculate total cost with correct discount logic
  def total_cost(duration = nil)
    duration ||= custom_duration || medication_dosage.dosage.default_duration

    frequency_multiplier = case medication_dosage.dosage.frequency.downcase
    when "once weekly" then 1.0/7
    when "twice weekly" then 2.0/7
    when "once daily" then 1
    when "twice daily" then 2
    else raise "Unknown frequency: #{medication_dosage.dosage.frequency}"
    end

    base_cost = medication_dosage.unit_price * duration * frequency_multiplier
    discount = discount_applicable?(duration) ? 0.9 : 1.0

    base_cost * discount
  end


  # Check if 10% discount applies (30+ days)
  def discount_applicable?(duration = nil)
    duration ||= custom_duration || medication_dosage.dosage.default_duration  # Ensure we always get a duration

    duration.to_i >= 30
  end
end
