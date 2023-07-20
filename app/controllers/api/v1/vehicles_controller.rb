class Api::V1::VehiclesController < ApplicationController
  def index
    vehicles = Vehicle.all
    render json: vehicles, status: :ok
  end

  def show
    vehicle = Vehicle.find_by_id(params[:id])

    if vehicle.present?
      render json: vehicle, status: :ok
    else
      render json: { error: "Vehicle not found" }
    end
  end

  def create
    vehicle = Vehicle.new(vehicle_params)

    if vehicle.save
      render json: vehicle, status: :ok
    else
      render json: vehicle.errors, status: :unprocessable_entity
    end
  end

  def vehicle_params
    params.require(:vehicle).permit(:licence_plate, :make, :model, :year)
  end
end
