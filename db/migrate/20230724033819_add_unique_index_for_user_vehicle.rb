class AddUniqueIndexForUserVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_index :users_vehicles, [:user_id, :vehicle_id]
    remove_index :users_vehicles, [:vehicle_id, :user_id]
    add_index :users_vehicles, [:vehicle_id, :user_id], unique: true
  end
end
