class PrescriptionItem < ApplicationRecord
  belongs_to :prescription
  belongs_to :medication_dosage
end
