FactoryBot.define do
  factory :prescription do
    patient_name { "John Doe" }
    budget { 100.00 } # Default budget

    transient do
      items_count { 2 }  # Default: 2 prescription items per prescription
      custom_items { [] } # Allows passing in specific items
    end

    after(:create) do |prescription, evaluator|
      # If custom items are provided, use them instead of auto-generating items
      if evaluator.custom_items.any?
        evaluator.custom_items.each do |item|
          create(:prescription_item, prescription: prescription, **item)
        end
      else
        create_list(:prescription_item, evaluator.items_count, prescription: prescription, medication_dosage: create(:medication_dosage, :cheap))
      end
    end

    # Trait for low budget with cheap medication and short duration
    trait :low_budget do
      budget { 50.00 }
    end

    # Trait for high budget
    trait :high_budget do
      budget { 200.00 }
    end

    # Trait for an over-budget prescription
    trait :over_budget do
      budget { 500.00 }
      items_count { 0 } # Override default count
      after(:create) do |prescription, evaluator|
        create_list(:prescription_item, 1, prescription: prescription,
          medication_dosage: create(:medication_dosage, :expensive)
        )
      end
    end
  end
end
