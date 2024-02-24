class Api::V1::PaymentsController < ApplicationController
  before_action :set_user, only: %w[index]

  def index
    render json: @user.payments, status: :ok
  end

  private

  def set_user
    @user = User.find_by(firebase_id: params[:user_id])
  end
end
