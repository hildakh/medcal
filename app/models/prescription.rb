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

  # Suggest reductions to bring total cost within budget
  def suggested_reductions
    return [] if valid_within_budget?

    suggestions = []
    excess_cost = total_cost - budget

    prescription_items.each do |item|
      original_duration = item.custom_duration
      original_cost = item.total_cost

      # Try reducing duration in steps
      [ 11, 8, 5 ].each do |reduced_duration|
        next if reduced_duration >= original_duration

        new_cost = item.total_cost(reduced_duration)
        savings = original_cost - new_cost

        if savings > 0
          suggestions << {
            medication: item.medication_dosage.medication.name,
            original_duration: original_duration,
            suggested_duration: reduced_duration,
            original_cost: original_cost,
            new_cost: new_cost,
            savings: savings
          }

          excess_cost -= savings
          break if excess_cost <= 0
        end
      end

      break if excess_cost <= 0
    end

    suggestions
  end

  # Apply suggested reductions to prescription
  def apply_adjustments
    return if valid_within_budget?

    suggestions = suggested_reductions

    return if suggestions.empty?

    suggestions.each do |suggestion|
      item = prescription_items.joins(medication_dosage: :medication).find_by(medication_dosages: { medications: { name: suggestion[:medication] } })

      if item.present?
        item.update!(custom_duration: suggestion[:suggested_duration])

        # Force recalculation of prescription total cost
        item.reload
        reload

        break if valid_within_budget?
      else
        puts "WARNING: Could not find item for #{suggestion[:medication]}"
      end
    end
  end
end
