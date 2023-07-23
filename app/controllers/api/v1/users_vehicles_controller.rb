class Api::V1::UsersVehiclesController < ApplicationController
    def index
        users_vehicles = UsersVehicle.all
        render json: users_vehicles, status: :ok
      end
    
      def show
        user_vehicle = UsersVehicle.find_by(user_id: params[:user_id], vehicle_id: params[:vehicle_id])
    
        if user_vehicle.present?
          render json: user_vehicle, status: :ok
        else
          render json: { error: "User vehicle not found" }
        end
      end
    
      def create
        user_vehicle = UsersVehicle.new(user_vehicle_params)
    
        if user_vehicle.save
          render json: user_vehicle, status: :ok
        else
          render json: user_vehicle.errors, status: :unprocessable_entity
        end
      end
    
      def user_vehicle_params
        params.require(:user_vehicle).permit(:user_id, :vehicle_id)
      end
end
