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
      push_tokens = ticket.users.pluck(:push_token)
      client = Exponent::Push::Client.new
      messages = []

      push_tokens.each do |push_token|
        messages.append({
          to: "ExponentPushToken[#{push_token}]",
          sound: "default",
          title: "New Ticket Received",
          body: "Vehicle with license plate #{ticket.vehicle.licence_plate} received a ticket"
        })
      end

      handler = client.send_messages(messages)
      

      render json: ticket, status: :ok
    else
      render json: ticket.errors, status: :unprocessable_entity
    end
  end

  def dispute
    if @ticket.status == "pending"
      @ticket.update(status: "in_dispute", dispute_reason: params[:reason])
    else
      @ticket.update(dispute_reason: "")
    end

    render status: :ok
  end

  def dispute_result
    @ticket.update(status: dispute_params["status"], reason: "")
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
