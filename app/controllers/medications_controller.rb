class MedicationsController < ApplicationController
  def index
    render json: Medication.all
  end

  def show
    render json: Medication.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
