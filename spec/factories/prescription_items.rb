FactoryBot.define do
  factory :prescription_item do
    prescription
    medication_dosage
    custom_duration { 14 } # Default duration (no discount)

    # Trait for long duration (30+ days for discount)
    trait :long_duration do
      custom_duration { 30 }
    end

    # Trait for very short duration
    trait :short_duration do
      custom_duration { 7 }
    end

    # Trait for an expensive medication
    trait :expensive do
      medication_dosage { association :medication_dosage, :expensive }
    end

    # Trait for a cheap medication
    trait :cheap do
      medication_dosage { association :medication_dosage, :cheap }
    end
  end
end
