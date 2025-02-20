FactoryBot.define do
  factory :medication_dosage do
    medication
    dosage
    unit_price { 5.00 }

    # Traits for different pricing levels
    trait :cheap do
      unit_price { 2.00 }
    end

    trait :expensive do
      unit_price { 50.00 }
    end

    trait :discounted do
      unit_price { 10.00 } # Before discount
    end

    # Trait to associate a high-dose dosage
    trait :high_dose do
      dosage { association :dosage, :high_dose }
    end

    # Trait to associate a twice-daily dosage
    trait :twice_daily do
      dosage { association :dosage, :twice_daily }
    end
  end
end
