class Prescription < ApplicationRecord
  has_many :prescription_items, dependent: :destroy
  has_many :medication_dosages, through: :prescription_items
  has_many :medications, through: :medication_dosages

  validates :patient_name, presence: true
  validates :budget, numericality: { greater_than: 0 }

  DEFAULT_BUDGET = 100.00

  before_validation :set_default_budget, on: :create

  # Set default budget if not provided
  def set_default_budget
    self.budget ||= DEFAULT_BUDGET
  end

  # Calculate total prescription cost
  def total_cost
    prescription_items.sum(&:total_cost)
  end

  # Validate if prescription is within budget
  def valid_within_budget?
    total_cost <= budget
  end

  # Suggest reductions if over budget
  def suggested_reductions
    return {} if valid_within_budget?

    prescription_items.map do |item|
      new_duration = (item.custom_duration * 0.8).to_i # Suggest 20% reduction
      {
        medication: item.medication_dosage.medication.name,
        original_duration: item.custom_duration,
        suggested_duration: new_duration,
        new_cost: item.calculate_cost(new_duration)
      }
    end
  end
end
