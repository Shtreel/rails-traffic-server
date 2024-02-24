class PaymentMailer < ApplicationMailer
  def send_payment_email
    @ticket = params[:ticket]

    mail(to: @ticket.users.pluck(:email), subject: "Waterloo Driver's App: Ticket Payment!")
  end
end
