class AddNonNullConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tickets, :cost, false
    change_column_null :tickets, :penalty_type, false
    change_column_null :tickets, :issue_date, false
    change_column_null :tickets, :due_date, false

    change_column_null :vehicles, :licence_plate, false
    change_column_null :vehicles, :make, false
    change_column_null :vehicles, :model, false
    change_column_null :vehicles, :year, false
  end
end
