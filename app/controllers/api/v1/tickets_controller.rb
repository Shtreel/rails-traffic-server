class Api::V1::TicketsController < ApplicationController
  def index
    tickets = Ticket.all
    render json: tickets, status: :ok
  end

  def show
    ticket = Ticket.find_by_id(params[:id])

    if ticket.present?
      render json: ticket, status: :ok
    else
      render json: { error: "Ticket not found" }
    end
  end

  def create
    ticket = Ticket.new(ticket_params)

    if ticket.save
      render json: ticket, status: :ok
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def ticket_params
    params.require(:ticket).permit([:vehicle_id, :cost, :penalty_type, :issue_date, :due_date])
  end
end
