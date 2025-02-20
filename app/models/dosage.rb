class Dosage < ApplicationRecord
  has_many :medication_dosages
  has_many :medications, through: :medication_dosages

  validates :amount, :frequency, :default_duration, presence: true
end
