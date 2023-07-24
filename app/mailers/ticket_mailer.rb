class TicketMailer < ApplicationMailer
    def ticket_notification(ticket)
        ticket.users
    end
end
