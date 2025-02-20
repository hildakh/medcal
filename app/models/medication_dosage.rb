class MedicationDosage < ApplicationRecord
  belongs_to :medication
  belongs_to :dosage
end
