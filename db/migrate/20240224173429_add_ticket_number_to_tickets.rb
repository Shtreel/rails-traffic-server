class AddTicketNumberToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :ticket_number, :string, null: false, unique: true
  end
end
