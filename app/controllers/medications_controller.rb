class MedicationsController < ApplicationController
  def index
    render json: Medication.all
  end

  def show
    medication = Medication.find(params[:id])
    render json: {
      id: medication.id,
      name: medication.name,
      dosages: medication.medication_dosages.map do |md|
        {
          id: md.dosage.id,
          amount: md.dosage.amount,
          frequency: md.dosage.frequency,
          default_duration: md.dosage.default_duration,
          unit_price: md.unit_price
        }
      end
    }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Medication not found" }, status: :not_found
  end

  def discount_applicable?(duration)
    duration.to_i >= 30
  end
end
