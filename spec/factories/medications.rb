FactoryBot.define do
  factory :medication do
    sequence(:name) { |n| "Medication #{n}" }
  end
end
