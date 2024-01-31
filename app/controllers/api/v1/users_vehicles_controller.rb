class Api::V1::UsersVehiclesController < ApplicationController
  def create
    vehicle_invitation = VehicleInvitation.find_by(code: users_vehicles_params[:code])
    user_id = User.find_by(firebase_id: users_vehicles_params[:user_id])&.id

    if vehicle_invitation.present && user_id.present && vehicle_invitation.vehicle.licence_plate == users_vehicles_params[:licence_plate]
      users_vehicle = UsersVehicle.new(user_id: user_id, vehicle: vehicle_invitation.vehicle)

      if users_vehicle.save
        render json: users_vehicle, status: :ok
      else
        render json: users_vehicle.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Could not find invitation" }, status: :unprocessable_entity
    end
  end

  def invite
    user = User.find_by(firebase_id: users_vehicles_invite_params[:user_id])

    unless UsersVehicle.find_by(user_id: user.id, vehicle_id: users_vehicles_invite_params[:vehicle_id]).primary
      render status: :forbidden

      return
    end

    invite_code = SecureRandom.hex(6)
    vehicle_invitation = VehicleInvitation.new(
      code: SecureRandom.hex(6).upcase,
      vehicle_id: users_vehicles_invite_params[:vehicle_id])

    if vehicle_invitation.save
      UsersVehicleMailer.with(vehicle_invitation: vehicle_invitation,
                              email: users_vehicles_invite_params[:email],
                              user: user)
                        .send_invite_email
                        .deliver_now
      
      render status: :ok
    else
      render status: :unprocessable_entity, error: vehicle_invitation.errors
    end
  end

  def users_vehicles_params
    params.require(:users_vehicle).permit(:licence_plate, :code, :user_id)
  end

  def users_vehicles_invite_params
    params.require(:users_vehicle).permit(:user_id, :vehicle_id, :email)
  end
end
