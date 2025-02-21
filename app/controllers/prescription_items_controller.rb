class PrescriptionItemsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      @prescription = Prescription.find(params[:prescription_id])

      medication = Medication.find(params[:medication][:id])
      dosage = Dosage.find(params[:dosage][:id])
      medication_dosage = MedicationDosage.find_by(medication: medication, dosage: dosage)

      unless medication_dosage
        raise ActiveRecord::RecordInvalid.new("Medication and Dosage combination not found")
      end

      @prescription_item = @prescription.prescription_items.create!(
        medication_dosage: medication_dosage,
        custom_duration: params[:duration] || dosage.default_duration
      )

      render json: {
        prescription_item: @prescription_item,
        id: @prescription.id,
        budget: @prescription.budget
      }, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
