class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [ :update ]

  def create
    ActiveRecord::Base.transaction do
      @prescription = Prescription.create!(prescription_params)

      if params[:items].present?
        create_prescription_items
        @prescription.reload
      end

      render json: {
        prescription: @prescription,
        total_cost: @prescription.total_cost,
        id: @prescription.id,
        items: @prescription.prescription_items
      }, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    if @prescription.update(budget: params[:budget])
      render json: { message: "Budget updated successfully", prescription: @prescription }, status: :ok
    else
      render json: { errors: @prescription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def prescription_params
    params.permit(:budget)
  end

  def create_prescription_items
    params[:items].each do |item|
      medication = Medication.find(item[:medication][:id])
      dosage = Dosage.find(item[:dosage][:id])
      medication_dosage = MedicationDosage.find_by(medication: medication, dosage: dosage)

      unless medication_dosage
        raise ActiveRecord::RecordInvalid.new("Medication and Dosage combination not found")
      end

      @prescription.prescription_items.create!(
        medication_dosage: medication_dosage,
        custom_duration: item[:duration] || dosage.default_duration
      )
    end
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Prescription not found" }, status: :not_found
  end
end
