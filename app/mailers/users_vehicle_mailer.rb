class UsersVehicleMailer < ApplicationMailer
  def send_invite_email
    @user = params[:user]
    @vehicle_invitation = params[:vehicle_invitation]

    mail(to: params[:email], subject: "Waterloo Driver's App: Vehicle Invitation!")
  end
end
