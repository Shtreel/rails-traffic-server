class Api::V1::TicketsController < ApplicationController
  def index
    tickets = User.find_by(firebase_id: params[:user_id]).tickets
    render json: tickets, status: :ok
  end

  def create
    ticket = Ticket.new(ticket_params)
    ticket.vehicle = Vehicle.find_by(licence_plate: params["ticket"]["licence_plate"], province: params["ticket"]["province"])

    if ticket.save
      render json: ticket, status: :ok
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def ticket_params
    params.require(:ticket).permit(:cost, :penalty_type, :issue_date, :due_date)
  end
end
