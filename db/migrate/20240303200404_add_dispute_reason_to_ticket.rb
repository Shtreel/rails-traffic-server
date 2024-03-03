class AddDisputeReasonToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :dispute_reason, :string
  end
end
