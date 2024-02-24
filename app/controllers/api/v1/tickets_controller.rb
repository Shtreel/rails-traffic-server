class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:dispute, :dispute_result, :payment_intent]

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

  def dispute
    @ticket.update(status: "in_dispute") if @ticket.status == "pending"

    render status: :ok
  end

  def dispute_result
    @ticket.update(status: dispute_params["status"])
  end

  def payment_intent
    payment_intent = Stripe::PaymentIntent.create({
      amount: (@ticket.cost * 100).round,
      currency: 'cad',
      metadata: { ticket_id: @ticket.id },
    })

    payment_intent_response = {
      paymentIntent: payment_intent['client_secret'],
      publishableKey: Rails.application.credentials.stripe.private_key
    }.to_json

    render json: payment_intent, status: :ok
  end

  private

  def ticket_params
    params.require(:ticket).permit(:ticket_number, :cost, :penalty_type, :issue_date, :due_date)
  end

  def dispute_params
    params.permit(:status)
  end

  def set_ticket
    @ticket = Ticket.find_by_id(params[:id]) || Ticket.find_by(ticket_number: params[:id])
  end
end
