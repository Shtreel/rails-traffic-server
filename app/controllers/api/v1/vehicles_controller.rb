class Api::V1::VehiclesController < ApplicationController
  before_action :set_user, only: [:index, :show]

  def index
    vehicles = []
    @user.vehicles.each do |vehicle|
      json_vehicle = vehicle.as_json
      json_vehicle["users"] = vehicle.users.where.not(id: @user.id).pluck(:name)
      vehicles.append(json_vehicle)
    end

    render json: vehicles, status: :ok
  end

  def show
    vehicle = @user.vehicles.find_by_id(params[:id])

    if vehicle.present?
      json_vehicle = vehicle.as_json
      json_vehicle["users"] = vehicle.users.where.not(id: @user.id).pluck(:name)

      render json: json_vehicle, status: :ok
    else
      render json: { error: "Vehicle not found" }
    end
  end

  def create
    new_vehicle_params = vehicle_params
    new_vehicle_params[:users_vehicles_attributes] = [user_id: User.find_by(firebase_id: params[:user_id]).id]
    vehicle = Vehicle.new(new_vehicle_params)

    if vehicle.save
      render json: vehicle, status: :ok
    else
      render json: vehicle.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(firebase_id: params[:user_id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:province, :licence_plate, :make, :model, :year)
  end
end
