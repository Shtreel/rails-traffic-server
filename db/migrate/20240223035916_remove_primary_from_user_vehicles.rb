class RemovePrimaryFromUserVehicles < ActiveRecord::Migration[7.0]
  def change
    remove_column :users_vehicles, :primary
  end
end
