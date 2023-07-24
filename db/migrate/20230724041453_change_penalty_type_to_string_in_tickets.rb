class ChangePenaltyTypeToStringInTickets < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :penalty_type, :string
  end
end
