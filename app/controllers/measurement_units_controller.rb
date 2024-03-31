class MeasurementUnitsController < ApplicationController
  before_action :set_measurement_unit, only: %i[show update destroy]
  skip_before_action :authenticate_user!
  
  def index
    @measurement_units = MeasurementUnit.all
    render json: @measurement_units
  end

  def show
    render json: @measurement_unit
  end

  def create
    @measurement_unit = MeasurementUnit.new(measurement_unit_params)
    authorize @measurement_unit
    if @measurement_unit.save
      render json: @measurement_unit, status: :created
    else
      render json: @measurement_unit.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @measurement_unit
    if @measurement_unit.update(measurement_unit_params)
      render json: @measurement_unit, status: :ok
    else
      render json: @measurement_unit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @measurement_unit
    @measurement_unit.destroy
    head :no_content
  end

  private

  def measurement_unit_params
    params.require(:measurement_unit).permit(:name, :symbol)
  end

  def set_measurement_unit
    @measurement_unit = MeasurementUnit.find(params[:id])
  end
end