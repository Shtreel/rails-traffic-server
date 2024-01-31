class Api::V1::VehiclesController < ApplicationController
  def index
    vehicles = User.find_by(firebase_id: params[:user_id]).vehicles
    render json: vehicles, status: :ok
  end

  def show
    vehicle = User.find_by(firebase_id: params[:user_id]).vehicles.find_by_id(params[:id])

    if vehicle.present?
      render json: vehicle, status: :ok
    else
      render json: { error: "Vehicle not found" }
    end
  end

  def create
    new_vehicle_params = vehicle_params
    new_vehicle_params[:users_vehicles_attributes] = [user_id: User.find_by(firebase_id: params[:user_id]).id, primary: true]
    vehicle = Vehicle.new(new_vehicle_params)

    if vehicle.save
      render json: vehicle, status: :ok
    else
      render json: vehicle.errors, status: :unprocessable_entity
    end
  end

  def vehicle_params
    params.require(:vehicle).permit(:province, :licence_plate, :make, :model, :year)
  end
end
