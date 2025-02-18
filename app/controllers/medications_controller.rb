class MedicationsController < ApplicationController
  def index
    render json: Medication.all
  end

  def show
    medication = Medication.find(params[:id])
    render json: medication

  rescue ActiveRecord::RecordNotFound
    render json: { error: "Medication not found" }, status: :not_found
  end

  def create
    # Placeholder in case we decide to give users ability to add a medication
  end

  def update
    # Placeholder for updating medication
  end

  def destroy
    # Placeholder for deleting medication
  end
end
