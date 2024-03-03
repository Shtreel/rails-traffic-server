class TicketMailer < ApplicationMailer
    def ticket_status_changed
        @ticket = params[:ticket]
        @previous_status = params[:previous_status]
        @dispute_result = params[:dispute_result]

        mail(to: @ticket.users.pluck(:email), subject: "Waterloo Driver's App: Ticket Status Updated")
    end
end
