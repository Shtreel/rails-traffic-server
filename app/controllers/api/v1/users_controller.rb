class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %w[show, push_token]
  
  def index
    users = User.all
    render json: users, status: :ok
  end
  
  def show
    @user = User.find_by(firebase_id: params[:id])

    if @user.present?
      render json: @user, status: :ok
    else
      render json: { error: "User not found" }
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def push_token
    @user.update(push_token: params[:push_token])
  end

  private

  def set_user
    @user = User.find_by(firebase_id: params[:id])
  end

  def user_params
    params.require(:user).permit(:firebase_id, :name, :phone_number, :email, :drivers_licence_number, :push_token)
  end
end
