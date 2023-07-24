class ChangeStatusOnTickets < ActiveRecord::Migration[7.0]
  def change
    Ticket.where(status: nil).update_all(status: "pending")
    change_column_default :tickets, :status, "pending"
    change_column_null :tickets, :status, false
  end
end
