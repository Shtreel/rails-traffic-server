class Api::V1::UsersVehiclesController < ApplicationController
  def create
    user_vehicle = UsersVehicle.new(user_id: User.find_by(firebase_id: users_vehicles_params[:user_id])&.id, vehicle_id: users_vehicles_params[:vehicle_id])

    if user_vehicle.save
      render json: user_vehicle, status: :ok
    else
      render json: user_vehicle.errors, status: :unprocessable_entity
    end
  end

  def users_vehicles_params
    params.require(:user_vehicle).permit(:user_id, :vehicle_id)
  end
end
