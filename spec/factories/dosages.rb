FactoryBot.define do
  factory :dosage do
    amount { "500 mg" }
    frequency { "once daily" }
    default_duration { 30 }

    # Traits for different variations
    trait :high_dose do
      amount { "1000 mg" }
    end

    trait :twice_daily do
      frequency { "twice daily" }
    end

    trait :short_duration do
      default_duration { 7 }
    end

    trait :long_duration do
      default_duration { 60 }
    end
  end
end
