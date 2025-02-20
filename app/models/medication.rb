class Medication < ApplicationRecord
  has_many :medication_dosages
  has_many :dosages, through: :medication_dosages

  validates :name, presence: true, uniqueness: true
end
