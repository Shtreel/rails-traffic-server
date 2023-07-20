class RenameTypeToPenaltyTypeInTickets < ActiveRecord::Migration[7.0]
  def change
    rename_column :tickets, :type, :penalty_type
  end
end
