class Prescription < ApplicationRecord
  has_many :prescription_items, dependent: :destroy
  has_many :medication_dosages, through: :prescription_items
  has_many :medications, through: :medication_dosages

  validates :patient_name, presence: true
  validates :budget, numericality: { greater_than: 0 }

  DEFAULT_BUDGET = 100.00

  before_validation :set_default_budget, on: :create

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

  # Ensure suggested reductions bring the total cost within budget
  def suggested_reductions
    return [] if valid_within_budget?

    remaining_budget = budget
    new_cost = total_cost
    suggestions = []

    # Sort items by highest cost first (optimize reduction)
    sorted_items = prescription_items.sort_by { |item| -item.total_cost }

    sorted_items.each do |item|
      break if new_cost <= budget

      # Calculate reduced duration (20% reduction per step)
      reduced_duration = (item.custom_duration * 0.8).to_i
      reduced_cost = item.calculate_cost(reduced_duration)

      # Apply reduction if it helps bring cost down
      if new_cost - (item.total_cost - reduced_cost) >= remaining_budget
        new_cost -= (item.total_cost - reduced_cost)
        suggestions << {
          medication: item.medication_dosage.medication.name,
          original_duration: item.custom_duration,
          suggested_duration: reduced_duration,
          original_cost: item.total_cost,
          new_cost: reduced_cost
        }
      end
    end

    suggestions
  end

  # Apply suggested reductions
  def apply_adjustments
    return if valid_within_budget?

    suggested_reductions.each do |suggestion|
      item = prescription_items.find_by(
        medication_dosage: MedicationDosage.joins(:medication)
                                           .find_by(medications: { name: suggestion[:medication] })
      )
      item.update!(custom_duration: suggestion[:suggested_duration])
    end
  end
end
