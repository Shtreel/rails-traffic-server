class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.bigint :vehicle_id
      t.decimal :cost
      t.integer :type
      t.datetime :issue_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
