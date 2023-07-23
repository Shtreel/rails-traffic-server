class CreateJoinTableUserVehicle < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :vehicles, column_options: { index: true, null: false, foreign_key: true } do |t|
      t.index [:user_id, :vehicle_id]
      t.index [:vehicle_id, :user_id]
    end
  end
end
