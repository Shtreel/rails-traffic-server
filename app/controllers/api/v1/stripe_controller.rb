class Api::V1::StripeController < ApplicationController
  def webhook
    payload = request.raw_post
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { error: { message: e.message }}, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { error: { message: e.message, extra: "Sig verification failed" }}, status: :bad_request
      return
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object # contains a Stripe::PaymentIntent

      # save to table and send email
      ticket_id = payment_intent.metadata.ticket_id
      Payment.create(payment_intent_id: payment_intent.id, ticket_id: ticket_id)
      ticket = Ticket.find(ticket_id)
      ticket.update(status: "paid")

      PaymentMailer.with(ticket: ticket)
                   .send_invite_email
                   .deliver_now
    end

    render json: { message: :success }
  end

  private

  def endpoint_secret
    (Rails.application.credentials.dig(:stripe, :signing_secret) || []).first
  end
end
